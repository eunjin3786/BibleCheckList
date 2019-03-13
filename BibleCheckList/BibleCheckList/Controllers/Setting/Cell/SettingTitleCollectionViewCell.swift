//
//  SettingTitleCollectionViewCell.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 12/03/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import UIKit

class SettingTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    private var isToggle = false
    
    func toggle() {
        isToggle = !isToggle
        setupToggleColor(isToggle: isToggle)
        
        if let title = titleLabel.text {
            RealmManager.shared.changeDaily(title: title, isDaily: isToggle)
        }
    }
    
    func setupToggleColor(isToggle: Bool) {
        if isToggle {
            backgroundColor = .lightMint
            titleLabel.textColor = .white
        } else {
            backgroundColor = .darkYellow
            titleLabel.textColor = .black
        }
    }
}
