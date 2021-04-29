//
//  CircleButtonGroupViewTest.swift
//  SwiftHackUITests
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import XCTest
@testable import SwiftHackUI

class CircleButtonGroupViewTest: XCTestCase, CircleButtonDelegate {
    
    var circleButtonGroupView = CircleButtonGroupView()
    
    override func setUp() {
        super.setUp()
        circleButtonGroupView.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testButtonGroup() {
        circleButtonGroupView.items = [CircleButtonItem(title: "B1"),
                                       CircleButtonItem(title: "B2"),
                                       CircleButtonItem(title: "B3")]
        XCTAssertEqual(circleButtonGroupView.items?.count, 3)
        XCTAssertEqual(circleButtonGroupView.circleButtons?.count, 3)
        
    }
    
    func buttonClicked(title: String?) {
      
    }

}
