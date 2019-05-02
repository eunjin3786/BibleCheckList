//
//  SettingViewModelTests.swift
//  BibleCheckListTests
//
//  Created by eunjin Jo on 13/04/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import XCTest
// 테스트 목적으로 BibleCheckList안에 있는 모든 것을 쓸거야 --!
@testable import BibleCheckList

class SettingViewModelTests: XCTestCase {
    private var settingVM: SettingViewModel!
    
    override func setUp() {
        super.setUp()
        settingVM = SettingViewModel()
    }
    
    // test independent 위해 아무것도 남기지 않는다
    // 각각의 테스트가 끝날때 마다 클린업된다
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
