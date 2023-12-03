//
//  TitleDescriptionView.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import UIKit

class TitleDescriptionView: UIView {
    
    private let contentContainerStack = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = .XS
        stack.layoutMargins = .init(top: .S, left: .M, bottom: .S, right: .M)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .label
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    convenience init(title: String, description: String) {
        self.init()
        configure(title: title, description: description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Setup
extension TitleDescriptionView {
    
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(contentContainerStack)
        contentContainerStack.addArrangedSubview(titleLabel)
        contentContainerStack.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentContainerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainerStack.topAnchor.constraint(equalTo: topAnchor),
            contentContainerStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

extension TitleDescriptionView {
    
    func configure(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
}
