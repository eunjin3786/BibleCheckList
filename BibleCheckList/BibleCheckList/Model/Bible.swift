//
//  Bible.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 20/11/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import Foundation

typealias BookTuple = (title: String, numOfpages: Int, category: Category)

struct Bible{
    
    static func getBibleInfoFromFile() -> [BookTuple]{
        var bible:[BookTuple] = []
        
        if let path = Bundle.main.path(forResource: "category_type_1", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                
                guard let newIndex:Int = myStrings.firstIndex(of: "신약 ") else {return []}
                
                
                for (index,item) in myStrings.enumerated(){
                    
                    guard let title = item.getArrayAfterRegex(regex: "[ㄱ-ㅎㅏ-ㅣ가-힣0-9]+()").first else{continue}
                    
                    guard let numString = item.getArrayAfterRegex(regex: "[(][(0-9)]+").first, let numOfPages = Int(numString[numString.index(after: numString.startIndex)...]) else{continue}
                    
                    if index < newIndex{
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
    
}

// 다 쓰기 어려우니까 텍스트 파일을 넣고 텍스트 읽어줄것임
// http://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&barcode=9788904502462&orderClick=JAE 타입여러개로
//https://stackoverflow.com/questions/31778700/read-a-text-file-line-by-line-in-swift
