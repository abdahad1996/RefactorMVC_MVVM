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
        
        
        XCTAssertEqual(sut.numberOfUsers(),0)

    }
    
    
    func test_ViewDidLoad_LoadsUsersFromApi() throws {
        
       let sut = try makeSUT()
       
        
        sut.getUsers = { completion in
            completion(.success(
                [
                    sut.makeUser(name:"user1",email:"email1"),
                    sut.makeUser(name:"user2",email:"email2"),
                    

                ]))
        }
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.numberOfUsers(),2)
        
        XCTAssertEqual(sut.name(AtRow: 0),"user1")
        XCTAssertEqual(sut.email(AtRow: 0),"email1")


    }
    
    func test_ViewDidLoad_WhenUserNameStartsWithC_HighlightCell() throws {
        
       let sut = try makeSUT()
       
        
        sut.getUsers = { completion in
            completion(.success(
                [
                    sut.makeUser(name:"C user0",email:"email0"),
                    sut.makeUser(name:"user1 C",email:"email1"),
                    sut.makeUser(name:"user2 C",email:"email2"),


                ]))
        }
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.numberOfUsers(),3)
        
        XCTAssertTrue(sut.highlights(AtRow: 0),"should be heighlighted")
        XCTAssertTrue(sut.notHighlights(AtRow: 1),"should  be heighlighted")
        XCTAssertTrue(sut.notHighlights(AtRow: 2),"should not be heighlighted")


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

private extension UsersTableVC {
     func makeUser(name:String, email:String) -> User {
        User(id: 0, name: name, email: email)
    }
    func name(AtRow row:Int) -> String? {
        return userCell(atRow:row)?.nameLabel.text
    }
    
    func email(AtRow row:Int) -> String? {
        return userCell(atRow:row)?.emailLabel.text
    }
    
    func highlights(AtRow row:Int) -> Bool {
        return userCell(atRow:row)?.backgroundColor == .green
    }
    
    func notHighlights(AtRow row:Int) -> Bool {
        return userCell(atRow:row)?.backgroundColor == .white
    }
    
    func userCell(atRow row:Int) -> UserCell?{
        let ds = tableView.dataSource
        let indexPath = IndexPath(row: row, section: UserSection)
        let cell = ds?.tableView(tableView, cellForRowAt: indexPath) as? UserCell
        return cell
    }
    func numberOfUsers() -> Int {
       return tableView.numberOfRows(inSection: UserSection)
    }
    
    private var UserSection:Int{0}
}
