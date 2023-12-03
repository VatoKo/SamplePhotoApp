//
//  AuthorInfoCell.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import UIKit

class AuthorInfoCell: UITableViewCell {
    
    private static let imageSize: CGFloat = 36.0
    
    private let contentContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = .S
        return stack
    }()
    
    private let authorPhotoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = imageSize / 2
        return view
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
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
extension AuthorInfoCell {
    
    private func setup() {
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(contentContainerStack)
        contentContainerStack.addArrangedSubview(authorPhotoView)
        contentContainerStack.addArrangedSubview(authorNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentContainerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .M),
            contentContainerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.M),
            contentContainerStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            authorPhotoView.widthAnchor.constraint(equalToConstant: AuthorInfoCell.imageSize),
            authorPhotoView.heightAnchor.constraint(equalToConstant: AuthorInfoCell.imageSize),
        ])
    }
    
}

extension AuthorInfoCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        authorPhotoView.sd_setImage(with: model.authorPhotoUrl)
        authorNameLabel.text = model.author
    }
    
}

extension AuthorInfoCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String = AuthorInfoCell.reuseIdentifier
        let authorPhotoUrl: URL?
        let author: String
    }
    
}
