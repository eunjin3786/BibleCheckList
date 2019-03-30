//
//  CheckListTableViewCell.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    private var bookVM: BookViewModel!
    
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
    
    private func setupCollectionViewHeight(){
        let lastIndex = IndexPath(item: bookVM.book.pageList.count-1, section: 0)
        if let att = collectionView.layoutAttributesForItem(at: lastIndex){
            collectionViewHeight.constant = att.frame.maxY
        }
    }
    
    private func setupCollectionView(){
        collectionView.register(UINib(nibName: "PageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageCollectionViewCell")
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
            flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    func configure(vm: BookViewModel) {
        bookVM = vm
        bookNameLabel.text = vm.book.title
        collectionView.reloadData()
        setupCollectionViewHeight()
    }
}


extension BookTableViewCell:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookVM.book.pageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: indexPath) as? PageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let page = bookVM.book.pageList[indexPath.row]
        cell.configure(page: page)
        return cell
    }
}

extension BookTableViewCell:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let page = bookVM.book.pageList[indexPath.row]
        bookVM.changeIsReadOfPage(page: page)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PageCollectionViewCell{
            cell.toggle(isRead: page.isRead)
        }
    }
}
