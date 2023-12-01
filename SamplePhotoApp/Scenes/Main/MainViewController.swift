//
//  MainViewController.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import UIKit

class MainViewController: UIViewController {
 
    var viewModel: MainPageViewModel!
    
    init(configurator: MainPageConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UIViewController Lifecycle
extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.loadImages()
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
