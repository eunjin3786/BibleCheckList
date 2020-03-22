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

protocol SettingDelegate {
    func settingsDone()
}

typealias SettingSectionModel = SectionModel<String, Book>
typealias SettingDataSource = RxCollectionViewSectionedReloadDataSource<SettingSectionModel>

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
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.rx.setDelegate(self).disposed(by: bag)
        bindCollectionView()
    }
    
    private func bindCollectionView() {
        let sections = settingVM.categories.map {
            return SettingSectionModel(model: $0.rawValue,
                                       items: settingVM.categoryBooks(for: $0.rawValue))
        }
        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: settingDatasource))
            .disposed(by: bag)
    }
    
    private var settingDatasource: SettingDataSource {
        let datasource = SettingDataSource.init(configureCell: { (datasource, collectionView, indexPath, book) -> UICollectionViewCell in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingTitleCollectionViewCell", for: indexPath) as? SettingTitleCollectionViewCell else { return UICollectionViewCell() }
            let book = self.settingVM.book(for: indexPath)
            cell.configure(vm: SettingTitleViewModel(book: book))
            return cell
        })
        datasource.configureSupplementaryView = { (datasource, collectionView, kind, indexPath) in
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SettingCollectionReusableView", for: indexPath) as? SettingCollectionReusableView {
                sectionHeader.titleLabel.text = self.settingVM.categories[indexPath.section].rawValue
                return sectionHeader
            }
            return UICollectionReusableView()
        }
        return datasource
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
