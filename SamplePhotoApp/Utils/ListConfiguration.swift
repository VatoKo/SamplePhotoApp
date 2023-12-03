//
//  ListConfiguration.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 02.12.23.
//

import Foundation

struct Section {
    let cells: [CellModel]
}

protocol ConfigurableCell {
    func configure(with model: CellModel)
}

protocol CellModel {
    var cellIdentifier: String { get }
}
