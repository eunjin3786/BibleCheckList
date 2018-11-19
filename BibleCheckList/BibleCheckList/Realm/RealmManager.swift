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


typealias BookTuple = (title:String,numOfpages:Int,category:Category)
// 다 쓰기 어려우니까 텍스트 파일을 넣고 텍스트 읽어줄것임
// http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&barcode=9788904502462&orderClick=JAE 타입여러개로
//https://stackoverflow.com/questions/31778700/read-a-text-file-line-by-line-in-swift

//시편 같은 예외케이스 처리 깔끔하게 해줄수있는 방법생각
//한글 utf8 정규표현식
//guard let 에 대해서도 생각
//코드정리
func getBibleInfoFromFile() -> [BookTuple]{
    
    var bible:[BookTuple] = []
    
    if let path = Bundle.main.path(forResource: "category_type_1", ofType: "txt") {
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            let myStrings = data.components(separatedBy: .newlines)
            
            guard let newIndex:Int = myStrings.firstIndex(of: "신약 ") else {return []}
            
            
            for (index,item) in myStrings.enumerated(){
                
                guard let title = item.getArrayAfterRegex(regex: "[ㄱ-ㅎㅏ-ㅣ가-힣0-9]+()").first else{continue}
                
                guard let numString = item.getArrayAfterRegex(regex: "[(][(0-9)]+").first, let numOfPages = Int(numString[numString.index(after: numString.startIndex)...]) else{continue}

                if title == "잠언" || title == "시편"{
                    bible.append((title,numOfPages,.daily))
                } else if index < newIndex{
                    bible.append((title,numOfPages,.old))
                } else {
                    bible.append((title,numOfPages,.new))
                }
            
            }

        } catch {
            print(error)
        }
    }
    
    return bible
}

class RealmManager{
    
    static let shared = RealmManager()
    
    private init(){
        if !getAllBooks().isEmpty{return}
        let bible = getBibleInfoFromFile()
        _ = bible.map{addBook($0)}
    }
    
    func addBook(_ bookTuple:BookTuple){
        
        //db에 추가
        let book = Book()
        book.title = bookTuple.title
        
        for i in 1...bookTuple.numOfpages{
            let pageObject = PageObject(pageNumber: String(i))
            book.pageList.append(pageObject)
        }

        book.category = bookTuple.category.rawValue
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
    
    func getBooksOfCategory(category:String)->[Book]{
        
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
    
    func chageAllRead(title:String){
        
        do{
            let realm = try Realm()
            let book = realm.objects(Book.self).filter{$0.title == title}.first
            try realm.write {
                
                //더찾아보기 map을 이용해서 값을 바꿔주는 방법
                //book?.pageList.map{$0.isRead = true}
                
                if let pageList = book?.pageList{
                    for page in pageList{
                        page.isRead = true
                    }
                }
                
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}
