//
//  InputWithErrorView.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import UIKit

class InputWithErrorView: UIView {
    
    private let contentContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = .S
        return stack
    }()
    
    let textfield: StandardInput = {
        let field = StandardInput()
        field.placeholder = "Email"
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        return field
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.isHidden = true
        return label
    }()
    
    var errorText: String? {
        didSet {
            if let errorText {
                errorLabel.isHidden = false
                errorLabel.text = errorText
            } else {
                errorLabel.isHidden = true
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Setup
extension InputWithErrorView {
    
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(contentContainerStack)
        contentContainerStack.addArrangedSubview(textfield)
        contentContainerStack.addArrangedSubview(errorLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentContainerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainerStack.topAnchor.constraint(equalTo: topAnchor),
            contentContainerStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
