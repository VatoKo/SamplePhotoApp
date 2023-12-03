//
//  MockUserDB.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

class MockUserDB {
    
    static let shared = MockUserDB()
    var users: [User] = []
    
    private init() {}
    
}
