//
//  SettingViewModel.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 15/03/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation

struct SettingViewModel {
    let categories = Category.allCases

    func book(for indexPath: IndexPath) -> Book {
        let sectionName = Category.allCases[indexPath.section].rawValue
        return categoryBooks(for: sectionName)[indexPath.row]
    }
    
    func categoryBooks(for name: String) -> [Book] {
        let books = RealmManager.shared.getAllBooks()
        return books.filter { $0.category == name }
    }
}
