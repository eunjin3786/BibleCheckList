//
//  SettingViewModel.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 15/03/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation

struct SettingViewModel {
    let books = RealmManager.shared.getAllBooks()
    let categories = Category.allCases

    func book(for indexPath: IndexPath) -> Book {
        let sectionName = categories[indexPath.section].rawValue
        return categoryBooks(for: sectionName)[indexPath.row]
    }
    
    func categoryBooks(for name: String) -> [Book] {
        return books.filter { $0.category == name }
    }
}
