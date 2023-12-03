//
//  ImageCell.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 02.12.23.
//

import UIKit

class ImageCell: UITableViewCell {
    
    private let myImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .secondarySystemFill
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        myImageView.layer.cornerRadius = .M
        myImageView.clipsToBounds = true
    }
    
}

// MARK: Setup
extension ImageCell {
    
    private func setup() {
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(myImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .M),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.M),
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            myImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/16)
        ])
    }
    
}

extension ImageCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        myImageView.sd_setImage(with: model.url)
    }
    
}

extension ImageCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String = ImageCell.reuseIdentifier
        let url: URL?
    }
    
}
