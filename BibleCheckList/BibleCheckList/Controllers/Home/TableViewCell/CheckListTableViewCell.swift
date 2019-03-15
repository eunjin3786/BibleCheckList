//
//  CheckListTableViewCell.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit

class CheckListTableViewCell: UITableViewCell {
    
    var book = Book(){
        didSet{
            updateCell()
        }
    }
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    private var estimateWidth = 35.0
    private var cellMarginSize = 3.0
    
    private func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(collectionView.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (collectionView.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
    
    //문제1 : 마지막 인덱스의 아이템의  maxY로 높이를 설정해주면 깔끔한데
    // se에서는 값을 correct하게 못찾는다 -> stack overflow에 올려보기
    //https://stackoverflow.com/questions/14674986/uicollectionview-set-number-of-columns
    private func setCollectionViewHeight(){
        let lastIndex = IndexPath(item: book.pageList.count-1, section: 0)
        if let att = collectionView.layoutAttributesForItem(at: lastIndex){
            collectionViewHeight.constant = att.frame.maxY
        }
    }
    
    private func setCollectionView(){
        collectionView.register(UINib(nibName: "PageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageCollectionViewCell")
        //xib파일에서 오토레이아웃 하려면 설정해주기 :)
        //https://zeddios.tistory.com/474
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
            flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        }
    }
  
    private func updateCell(){
        bookNameLabel.text = book.title
        collectionView.reloadData()
        setCollectionViewHeight()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
}


extension CheckListTableViewCell:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book.pageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: indexPath) as? PageCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        let page = book.pageList[indexPath.row]
        cell.configure(page: page)
        return cell
    }
}

extension CheckListTableViewCell:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let page = book.pageList[indexPath.row]
        RealmManager.shared.changeIsReadOfPage(title: book.title, pageNumber: page.pageNumber, isRead: !page.isRead)

        if let cell = collectionView.cellForItem(at: indexPath) as? PageCollectionViewCell{
            cell.toggle(isRead:page.isRead)
        }
    }
}
