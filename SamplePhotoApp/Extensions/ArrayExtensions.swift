//
//  ArrayExtensions.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import Foundation

extension Array {
    
    /// Returns new array with new element inserted between each element
    /// [1, 2, 3].insertedBetweenEachElement(0)
    /// [1, 0, 2, 0, 3]
    func insertedBetweenEachElement(_ newElement: Element) -> Self {
        return Array(self.map { [$0] }.joined(separator: [newElement]))
    }
    
}
