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


class RealmManager{
    
    static let shared = RealmManager()
    
    private init(){
        if !getAllBooks().isEmpty{return}
    
        
        addBook(title: "창세기", numOfpages: 50,category: .old)
        addBook(title: "출애굽기", numOfpages: 40, category: .old)
        addBook(title: "레위기", numOfpages: 27, category: .old)
        addBook(title: "시편", numOfpages: 150, category: .daily)
    }
    
    func addBook(title:String,numOfpages:Int,category:Category){
        
        //db에 추가
        let book = Book()
        book.title = title
        
        for i in 1...numOfpages{
            let pageObject = PageObject(pageNumber: String(i))
            book.pageList.append(pageObject)
        }

        book.category = category.rawValue
        book.add()
    }
    
    
    func getAllBooks()->[Book]{
        
        var bookList:[Book] = []
        
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
    
    
}
