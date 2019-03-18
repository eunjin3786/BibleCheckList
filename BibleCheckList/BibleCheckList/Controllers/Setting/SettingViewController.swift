//
//  SettingViewController.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 06/03/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol SettingDelegate{
    func settingsDone()
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func dismissAction(_ sender: Any) {
        if let delegate = delegate {
            delegate.settingsDone()
        }
        dismiss(animated: true)
    }
    
    private var settingVM = SettingViewModel()
    var delegate: SettingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return settingVM.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingVM.categoryBooks(for: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingTitleCollectionViewCell", for: indexPath) as? SettingTitleCollectionViewCell {
            let book = settingVM.book(for: indexPath)
            cell.configure(vm: SettingTitleViewModel(book: book))
            return cell
        }
        
        return UICollectionViewCell() 
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SettingCollectionReusableView", for: indexPath) as? SettingCollectionReusableView{
            sectionHeader.titleLabel.text = settingVM.categoryTitle(for: indexPath.section)
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}

extension SettingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.size.width / 4
        return CGSize(width: cellWidth, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = collectionView.cellForItem(at: indexPath) as? SettingTitleCollectionViewCell {
            item.toggle()
        }
    }
}
