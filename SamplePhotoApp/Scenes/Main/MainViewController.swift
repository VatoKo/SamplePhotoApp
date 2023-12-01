//
//  MainViewController.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import UIKit
import Combine

class MainViewController: UIViewController {
     
    private var cancellables = Set<AnyCancellable>()
    
    enum Section {
        case images
    }
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let sidePadding: CGFloat = .M
        let itemSize = (view.bounds.width - (2 * sidePadding)) / 5
        layout.itemSize = .init(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = .M
        layout.minimumLineSpacing = .M
        layout.sectionInset = .init(top: .zero, left: sidePadding, bottom: .zero, right: sidePadding)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "ImageCollectionCell")
        return view
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, ImageData> = {
        UICollectionViewDiffableDataSource<Section, ImageData>(collectionView: self.collectionView) { collectionView, indexPath, imageData in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
            cell.configure(with: .init(url: URL(string: imageData.previewURL!)!, description: imageData.user!))
            return cell
        }
    }()
    
    var viewModel: MainPageViewModel!
    var router: MainPageRouter!
    
    init(configurator: MainPageConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reloadDataSource(with data: [ImageData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ImageData>.init()
        snapshot.appendSections([.images])
        snapshot.appendItems(data)
        dataSource.apply(snapshot)
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
        setupBindings()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.images.receive(on: DispatchQueue.main).sink { [weak self] images in
            guard let self else { return }
            self.reloadDataSource(with: images)
        }.store(in: &cancellables)
        
        viewModel.route.receive(on: DispatchQueue.main).sink { [weak self] route in
            guard let self else { return }
            switch route {
            case .details(let imageData):
                self.router.navigateToImageDetails(imageData)
            }
        }.store(in: &cancellables)
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let imageData = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.didSelectImage(imageData)
    }
    
}
