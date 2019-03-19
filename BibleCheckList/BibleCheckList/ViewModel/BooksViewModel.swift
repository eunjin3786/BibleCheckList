//
//  BooksViewModel.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 15/03/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import RxSwift

struct BooksViewModel {
    let books = Variable.init([Book]())
    
    mutating func setupBooksOfCategory(name: String) {
        if name == "Daily" {
            books.value =  RealmManager.shared.getAllBooks().filter{ $0.isDaily == true }
        } else {
            books.value = RealmManager.shared.getBooksOfCategory(category: name).filter{ $0.isDaily == false }
        }
    }
}
