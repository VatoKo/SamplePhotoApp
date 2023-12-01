//
//  MainViewController.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import UIKit

class MainViewController: UIViewController {
    
}

// MARK: UIViewController Lifecycle
extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

// MARK: Setup
extension MainViewController {
    
    private func setup() {
        title = "Main"
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
}
