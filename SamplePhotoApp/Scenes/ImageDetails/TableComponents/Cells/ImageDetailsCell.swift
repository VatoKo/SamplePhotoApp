//
//  ImageDetailsCell.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import UIKit

class ImageDetailsCell: UITableViewCell {
    
    private let contentContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = .S
        return stack
    }()
    
    private let leftView: TitleDescriptionView = {
        let view = TitleDescriptionView()
        view.backgroundColor = .secondarySystemFill
        view.clipsToBounds = true
        view.layer.cornerRadius = .M
        return view
    }()
    
    private let rightView: TitleDescriptionView = {
        let view = TitleDescriptionView()
        view.backgroundColor = .secondarySystemFill
        view.clipsToBounds = true
        view.layer.cornerRadius = .M
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Setup
extension ImageDetailsCell {
    
    private func setup() {
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(contentContainerStack)
        contentContainerStack.addArrangedSubview(leftView)
        contentContainerStack.addArrangedSubview(rightView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentContainerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .M),
            contentContainerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.M),
            contentContainerStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}

// MARK: Configuration
extension ImageDetailsCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        if let leftViewModel = model.leftViewModel {
            leftView.isHidden = false
            leftView.configure(title: leftViewModel.title, description: leftViewModel.desciption)
        } else {
            leftView.isHidden = true
        }
        if let rightViewModel = model.rightViewModel {
            rightView.isHidden = false
            rightView.configure(title: rightViewModel.title, description: rightViewModel.desciption)
        } else {
            rightView.isHidden = true
        }
    }
    
}

extension ImageDetailsCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String = ImageDetailsCell.reuseIdentifier
        
        struct TitleDescription {
            let title: String
            let desciption: String
        }
        
        let leftViewModel: TitleDescription?
        let rightViewModel: TitleDescription?
        
        init(leftViewModel: ImageDetailsCell.ViewModel.TitleDescription?, rightViewModel: ImageDetailsCell.ViewModel.TitleDescription? = nil) {
            self.leftViewModel = leftViewModel
            self.rightViewModel = rightViewModel
        }
    }
    
}
