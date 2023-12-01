//
//  SignUpViewController.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import UIKit
import Combine

protocol SignUpDelegate: AnyObject {
    func signUp(_ sender: SignUpViewController, didCreate user: User)
}

class SignUpViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let textfieldsContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = .S
        stack.layoutMargins = .init(top: .S, left: .S, bottom: .S, right: .S)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.cornerRadius = .M
        stack.backgroundColor = .secondarySystemGroupedBackground
        return stack
    }()
    
    private lazy var emailField: StandardInput = {
        let field = StandardInput()
        field.placeholder = "Email"
        field.textPublisher.assign(to: \.email, on: viewModel).store(in: &cancellables)
        return field
    }()
    
    private lazy var passwordField: StandardInput = {
        let field = StandardInput()
        field.placeholder = "Password"
        field.textPublisher.assign(to: \.password, on: viewModel).store(in: &cancellables)
        return field
    }()
    
    private lazy var ageField: StandardInput = {
        let field = StandardInput()
        field.placeholder = "Age"
        field.keyboardType = .numberPad
        field.textPublisher.map({ Int($0 ?? "") }).assign(to: \.age, on: viewModel).store(in: &cancellables)
        return field
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.addAction(
            UIAction(handler: { [unowned self] _ in
                viewModel.createAnUser()
            }),
            for: .touchUpInside
        )
        return button
    }()
    
    var viewModel: SignUpViewModel!
    var router: SignUpRouter!
    weak var delegate: SignUpDelegate?
    
    init(configurator: SignUpConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UIViewController Lifecycle
extension SignUpViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

// MARK: Setup
extension SignUpViewController {
    
    private func setup() {
        title = "Sign up"
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        setupBindings()
    }
    
    private func addSubviews() {
        view.addSubview(textfieldsContainerStack)
        view.addSubview(signUpButton)
        textfieldsContainerStack.addArrangedSubview(emailField)
        textfieldsContainerStack.addArrangedSubview(passwordField)
        textfieldsContainerStack.addArrangedSubview(ageField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textfieldsContainerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .M),
            textfieldsContainerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.M),
            textfieldsContainerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .M)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .M),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.M),
            signUpButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -.M)
        ])
    }
    
    private func setupBindings() {
        viewModel.signUpResult.receive(on: DispatchQueue.main).sink { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                self.delegate?.signUp(self, didCreate: user)
            case .failure(let error):
                let alert = UIAlertController(title: "Sign up", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default))
                self.present(alert, animated: true)
            }
        }.store(in: &cancellables)
    }
    
}
