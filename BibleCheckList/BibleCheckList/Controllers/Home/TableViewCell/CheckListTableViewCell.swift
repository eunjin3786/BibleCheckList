//
//  CheckListTableViewCell.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class CheckListTableViewCell: UITableViewCell {
    
    let bookVM = BookViewModel()
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    private var estimateWidth = 35.0
    private var cellMarginSize = 3.0
    
    let bag = DisposeBag()
    
    private func calculateWidth() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(collectionView.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (collectionView.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
    
    private func setupCollectionView(){
        collectionView.register(UINib(nibName: "PageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageCollectionViewCell")
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
            flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
        }
        
        collectionView.rx.setDelegate(self).disposed(by: bag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        bindCollectionView()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    func configure(book: Book) {
        bookVM.title.value = book.title
        bookVM.pages.value = book.pageList.map { return $0 }
        bookVM.pages.asObservable().subscribe(onNext: { [weak self] (pages) in
            let lastIndex = IndexPath(item: pages.count-1, section: 0)
            if let att = self?.collectionView.layoutAttributesForItem(at: lastIndex){
                self?.collectionViewHeight.constant = att.frame.maxY
            }
        }).disposed(by: bag)
    }
    
    private func bindCollectionView() {
        bookVM.pages.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "PageCollectionViewCell", cellType: PageCollectionViewCell.self)){ (_, page, cell) in
            cell.configure(page: page)
        }.disposed(by: bag)
    }
}

extension CheckListTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculateWidth()
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let page = bookVM.pages.value[indexPath.row]
        bookVM.changeIsReadOfPage(page: page)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PageCollectionViewCell{
            cell.toggle(isRead: page.isRead)
        }
    }
}
