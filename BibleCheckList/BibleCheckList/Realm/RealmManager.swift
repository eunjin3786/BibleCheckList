//
//  RealmManager .swift
//  BibleCheckList
//
//  Created by eunjin Jo on 05/11/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//
//https://medium.com/@riccione83/easy-use-of-realm-in-swift-444f41a5742d
import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init(){
        if !getAllBooks().isEmpty { return }
        let bible = Bible.getBibleInfoFromFile()
        bible.forEach{ addBook($0) }
    }
    
    private func addBook(_ bookTuple: BookTuple){
        
        //db에 추가
        let book = Book()
        book.title = bookTuple.title
        
        for i in 1...bookTuple.numOfpages{
            let pageObject = PageObject(pageNumber: String(i))
            book.pageList.append(pageObject)
        }

        book.category = bookTuple.category.rawValue
        
        if book.title == "잠언" || book.title == "시편" {
            book.isDaily = true
        }
        
        book.add()
    }
    
    
    func getAllBooks()->[Book]{
        
        var bookList: [Book] = []
        
        do {
            let realm = try Realm()
            let results = realm.objects(Book.self)
            //Results<Book> 타입
            bookList = results.map{$0}
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return bookList
    }
    
    func getBooksOfCategory(category: String)->[Book]{
        
        var bookList:[Book] = []
        
        do {
            let realm = try Realm()
            let books = realm.objects(Book.self).filter{$0.category == category}
            bookList = books.map{$0}
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return bookList
        
    }
    
    
    func getBook(title:String)->Book?{
        
        do{
            let realm = try Realm()
            let book = realm.objects(Book.self).filter{$0.title == title}.first
            return book
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func changeIsReadOfPage(title:String, pageNumber:String, isRead:Bool){
        
        do{
            let realm = try Realm()
            let book = realm.objects(Book.self).filter{$0.title == title}.first
            try realm.write {
                let page = book?.pageList.filter{$0.pageNumber == pageNumber}.first
                page?.isRead = isRead
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func changeAllRead(title:String,isRead:Bool){
        do{
            let realm = try Realm()
            let book = realm.objects(Book.self).filter{$0.title == title}.first
            try realm.write {

                if let pageList = book?.pageList{
                    for page in pageList{
                        page.isRead = isRead
                    }
                }
                
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func changeDaily(title: String, isDaily: Bool) {
        do{
            let realm = try Realm()
            let book = realm.objects(Book.self).filter{$0.title == title}.first
            try realm.write {
                book?.isDaily = isDaily
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
