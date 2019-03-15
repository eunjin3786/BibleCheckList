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
    
    func categoryTitle(for index: Int) -> String {
        return categories[index].rawValue
    }
    
    func categoryBooks(for index: Int) -> [Book] {
        return books.filter { $0.category == categoryTitle(for: index) }
    }
    
    func book(for indexPath: IndexPath) -> Book {
        return categoryBooks(for: indexPath.section)[indexPath.row]
    }
}
