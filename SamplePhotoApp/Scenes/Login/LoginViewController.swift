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
        stack.layoutMargins = .init(top: .S, left: .S, bottom: .S, right: .S)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.cornerRadius = .M
        stack.backgroundColor = .secondarySystemGroupedBackground
        return stack
    }()
    
    private lazy var emailField: StandardInput = {
        let field = StandardInput()
        field.placeholder = "Email"
        field.textPublisher.sink { value in
            print("Email: \(value)")
        }.store(in: &cancellables)
        return field
    }()
    
    private lazy var passwordField: StandardInput = {
        let field = StandardInput()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.textPublisher.sink { value in
            print("Password: \(value)")
        }.store(in: &cancellables)
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("Log in", for: .normal)
        button.addAction(
            UIAction(handler: { _ in
                print("Did tap login")
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
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
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
    
}
