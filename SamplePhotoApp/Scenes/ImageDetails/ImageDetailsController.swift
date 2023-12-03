//
//  ImageDetailsController.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import UIKit
import Combine

class ImageDetailsController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    var sections: [Section] = []
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.register(ImageCell.self)
        view.register(ImageDetailsCell.self)
        view.register(SpacerCell.self)
        view.register(AuthorInfoCell.self)
        return view
    }()
    
    var viewModel: ImageDetailsViewModel!
    
    init(configurator: ImageDetailsConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sections(with details: ImageDetailsProvider) -> [Section] {
        [
            Section(
                cells: [
                    ImageCell.ViewModel(url: details.url),
                    ImageDetailsCell.ViewModel(
                        leftViewModel: .init(title: "Size", desciption: details.imageSize?.description ?? ""),
                        rightViewModel: .init(title: "Type", desciption: details.imageType ?? "")
                    ),
                    ImageDetailsCell.ViewModel(
                        leftViewModel: .init(title: "Tags", desciption: details.imageTags?.joined(separator: ", ") ?? "")
                    )
                ].insertedBetweenEachElement(SpacerCell.ViewModel(color: .systemBackground, height: .S))
            ),
            Section(
                cells: [
                    AuthorInfoCell.ViewModel(authorPhotoUrl: details.imageAuthorPhotoUrl, author: details.imageAuthor ?? ""),
                    SpacerCell.ViewModel(color: .systemBackground, height: .XS),
                    ImageDetailsCell.ViewModel(leftViewModel: .init(title: "Views", desciption: details.numberOfViews?.description ?? "")),
                    ImageDetailsCell.ViewModel(leftViewModel: .init(title: "Likes", desciption: details.numberOfLikes?.description ?? "")),
                    ImageDetailsCell.ViewModel(leftViewModel: .init(title: "Comments", desciption: details.numberOfComments?.description ?? "")),
                    ImageDetailsCell.ViewModel(leftViewModel: .init(title: "Downloads", desciption: details.numberOfDownloads?.description ?? "")),
                ].insertedBetweenEachElement(SpacerCell.ViewModel(color: .systemBackground, height: .XS))
            )
        ].insertedBetweenEachElement(Section(cells: [SpacerCell.ViewModel(color: .systemBackground, height: .M)]))
    }
    
}

// MARK: UIViewController Lifecycle
extension ImageDetailsController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.loadData()
    }
    
}

// MARK: Setup
extension ImageDetailsController {
    
    private func setup() {
        title = "Details"
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        setupBindings()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.imageDetailsProvider.receive(on: DispatchQueue.main).sink { [unowned self] details in
            self.sections = self.sections(with: details)
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }
    
}

extension ImageDetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].cells[indexPath.row]
        let dequeued = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath)
        let cell = dequeued as! ConfigurableCell
        cell.configure(with: model)
        return dequeued
    }
    
}
