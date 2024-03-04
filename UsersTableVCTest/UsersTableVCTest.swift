//
//  UsersTableVCTest.swift
//  UsersTableVCTest
//
//  Created by macbook abdul on 04/03/2024.
//

import XCTest
@testable import EDeveloperMVC

final class UsersTableVCTest: XCTestCase {

    func testCanInit() throws {
        let sut = try makeSUT()
        
    }
    
    func test_ViewDidLoad_SetsTitle() throws {
        
       let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "Users")
     
        
    }
    
    func test_ViewDidLoad_ConfiguresTableView() throws {
        
       let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)

    }
    
    func test_ViewDidLoad_InitialState() throws {
        
       let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0),0)

    }
    
    
    func test_ViewDidLoad_LoadsUsersFromApi() throws {
        
       let sut = try makeSUT()
       
        
        sut.getUsers = { completion in
            completion(.success(
                [
                    User(id: 0, name: "user1", email: "email1"),
                    User(id: 1, name: "user2", email: "email2")

                ]))
        }
        
        sut.loadViewIfNeeded()
//        let exp = expectation(description: "wait for api")
//        exp.isInverted = true
//       
//        wait(for: [exp],timeout:0.1)
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0),2)
        

    }
    
    private func makeSUT() throws -> UsersTableVC {
        let bundle = Bundle(for: UsersTableVC.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        let navigation = try XCTUnwrap(initialVC as? UINavigationController)
        
       let sut = try XCTUnwrap(navigation.topViewController as? UsersTableVC)
        sut.getUsers = { _ in }
        
        return sut
    }
    
    
    
}


