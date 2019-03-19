//
//  BookViewModel.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 15/03/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import RxSwift

struct BookViewModel {
    
    let title = Variable<String>("")
    let pages = Variable.init([PageObject]())

    func changeAllRead(isRead: Bool) {
        RealmManager.shared.changeAllRead(title: title.value, isRead: true)
    }
    
    func changeIsReadOfPage(page: PageObject) {
        RealmManager.shared.changeIsReadOfPage(title: title.value, pageNumber: page.pageNumber, isRead: !page.isRead)
    }
}
