//
//  SettingViewModelTests.swift
//  BibleCheckListTests
//
//  Created by eunjin Jo on 13/04/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import XCTest
@testable import BibleCheckList

class SettingViewModelTests: XCTestCase {
    private var settingVM: SettingViewModel!
    
    override func setUp() {
        super.setUp()
        settingVM = SettingViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testIsValidCatergories() {
        Category.allCases.forEach {
            XCTAssertNotNil(settingVM.categoryBooks(for: $0.rawValue))
        }
    }
    
    func testCategoryChange() {
        let firstBookName = settingVM.categoryBooks(for: "구약").first?.title
        XCTAssertEqual(firstBookName, "창세기")
    }
}
