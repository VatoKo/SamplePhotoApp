//
//  SpacerCell.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import UIKit

class SpacerCell: UITableViewCell {
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = contentView.heightAnchor.constraint(equalToConstant: .zero)
        constraint.isActive = true
        return constraint
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SpacerCell: ConfigurableCell {
    
    func configure(with model: CellModel) {
        guard let model = model as? ViewModel else { return }
        contentView.backgroundColor = model.color
        heightConstraint.constant = model.height
    }
    
}

extension SpacerCell {
    
    struct ViewModel: CellModel {
        var cellIdentifier: String = SpacerCell.reuseIdentifier
        let color: UIColor
        let height: CGFloat
    }
    
}
