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
    
    private func makeSUT() throws -> UsersTableVC {
        let bundle = Bundle(for: UsersTableVC.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        let navigation = try XCTUnwrap(initialVC as? UINavigationController)
        
       let sut = try XCTUnwrap(navigation.topViewController as? UsersTableVC)
        
        return sut
    }
    
}
