//
//  LoginViewController.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 27.11.23.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()
    
    private let contentContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = .M
        return stack
    }()
    
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
        field.isSecureTextEntry = true
        field.textPublisher.assign(to: \.password, on: viewModel).store(in: &cancellables)
        return field
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("Log in", for: .normal)
        button.addAction(
            UIAction(handler: { [unowned self] _ in
                viewModel.login()
            }),
            for: .touchUpInside
        )
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(configuration: .borderedTinted())
        button.setTitle("Sign up", for: .normal)
        button.addAction(
            UIAction(handler: { _ in
                print("Did tap sign up")
            }),
            for: .touchUpInside
        )
        return button
    }()
    
    var viewModel: LoginViewModel!
    var router: LoginRouter!
    
    init(configurator: LoginConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UIViewController Lifecycle
extension LoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

// MARK: Setup
extension LoginViewController {
    
    private func setup() {
        title = "Log in"
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        setupBindings()
    }
    
    private func addSubviews() {
        view.addSubview(contentContainerStack)
        contentContainerStack.addArrangedSubview(textfieldsContainerStack)
        textfieldsContainerStack.addArrangedSubview(emailField)
        textfieldsContainerStack.addArrangedSubview(passwordField)
        contentContainerStack.addArrangedSubview(loginButton)
        contentContainerStack.addArrangedSubview(signUpButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentContainerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .M),
            contentContainerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.M),
            contentContainerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .M)
        ])
    }
    
    private func setupBindings() {
        viewModel.route.receive(on: DispatchQueue.main).sink { route in
            switch route {
            case .main: self.router.navigateMainPage()
            }
        }.store(in: &cancellables)
    }
    
}
