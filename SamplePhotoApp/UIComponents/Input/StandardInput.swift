//
//  StandardInput.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 27.11.23.
//

import UIKit
import Combine

class StandardInput: UITextField {
    
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
    
    private var centerInset: CGPoint = .init(x: .S, y: .M) {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupBorder()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }

    private func insetTextRect(forBounds bounds: CGRect) -> CGRect {
        let insetBounds = bounds.insetBy(dx: centerInset.x, dy: centerInset.y)
        return insetBounds
    }
    
    private func setupBorder() {
        layer.cornerRadius = .S
        layer.masksToBounds = true
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        layer.borderWidth = 1
    }
    
}
