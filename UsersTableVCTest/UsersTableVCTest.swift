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
        let bundle = Bundle(for: UsersTableVC.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        let navigation = try XCTUnwrap(initialVC as? UINavigationController)
        
       let _ = try XCTUnwrap(navigation.topViewController as? UsersTableVC)
        
    }
}
