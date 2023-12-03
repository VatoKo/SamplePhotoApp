//
//  ImageCollectionCell.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import UIKit
import SDWebImage

class ImageCollectionCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        return view
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let initialColor = UIColor.black
        let finalColor = UIColor.clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.type = .axial
        gradientLayer.colors = [initialColor.cgColor, finalColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = imageView.bounds
        return gradientLayer
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = .M
        imageView.layer.addSublayer(gradientLayer)
    }
    
}

// MARK: Setup
extension ImageCollectionCell {
    
    private func setup() {
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .S),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.S),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.S)
        ])
    }
    
}

// MARK: Configuration
extension ImageCollectionCell {
    
    func configure(with model: ViewModel) {
        imageView.sd_setImage(with: model.url)
        descriptionLabel.text = model.description
    }
    
}

// MARK: View Model
extension ImageCollectionCell {
    
    struct ViewModel {
        let url: URL
        let description: String
    }
    
}

