//
//  SettingTitleViewModel.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 15/03/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation

struct SettingTitleViewModel {
    let book: Book
    init(book: Book) {
        self.book = book
    }
    
    func changeIsDaily(on: Bool) {
        RealmManager.shared.changeDaily(title: book.title, isDaily: on)
    }
}
