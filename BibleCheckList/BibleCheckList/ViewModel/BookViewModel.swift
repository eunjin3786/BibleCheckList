//
//  BookViewModel.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 15/03/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation

struct BookViewModel {
    let book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func changeAllRead(isRead: Bool) {
        RealmManager.shared.changeAllRead(title: book.title, isRead: true)
    }
    
    func changeIsReadOfPage(page: PageObject) {
        RealmManager.shared.changeIsReadOfPage(title: book.title, pageNumber: page.pageNumber, isRead: !page.isRead)
    }
}
