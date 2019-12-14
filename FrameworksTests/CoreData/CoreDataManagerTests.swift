//
//  CoreDataManagerTests.swift
//  FrameworksTests
//
//  Created by Dimic Milos on 12/14/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import XCTest
@testable import Frameworks

class CoreDataManagerTests: XCTestCase {
    
    var sut = CoreDataManager()
    let entity = CoreDataManager.Entity.CoreDataUser
    
    override func tearDown() {
        super.tearDown()
        
        sut.deleteAllObjects(inEntity: entity)
    }
    
    func test_createUser_createsUserWithProvidedParameters() {
        // Given
        let id = UUID()
        let subscription = "none"
        
        // When
        let user = sut.createUser(subscription: subscription, id: id, entity: entity)
        
        // Then
        XCTAssertNotNil(user)
        XCTAssertEqual(id, user?.id)
        XCTAssertEqual(subscription, user?.subscription)
    }

    func test_fetchAllUsers_whenNoUsers_returnsEmptyArray() {
        // Given
        sut.deleteAllObjects(inEntity: entity)
        
        // When
        let users = sut.readAllUsers()
        
        // Then
        XCTAssertNotNil(users)
        XCTAssertTrue(users!.isEmpty)
    }
    
    func test_fetchAllUsers_whenOneUsersIsCreated_returnsArrayWithOneUser() {
        // Given
        let id = UUID()
        let subscription = "none"
        let _ = sut.createUser(subscription: subscription, id: id, entity: entity)
        
        // When
        let users = sut.readAllUsers()
        
        // Then
        XCTAssertNotNil(users)
        XCTAssertTrue(users!.count == 1)
    }
    
}
