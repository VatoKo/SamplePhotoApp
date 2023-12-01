//
//  MockUserDB.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

class MockUserDB {
    
    static let shared = MockUserDB()
    var users: [User] = [User(email: "A", password: "a", age: 0)]
    
    private init() {}
    
}
