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
    private var settingTitleVM: SettingTitleViewModel?
    
    func toggle() {
        isToggle = !isToggle
        setupToggleColor(isToggle: isToggle)
        settingTitleVM?.changeIsDaily(on: isToggle)
    }
    
    private func setupToggleColor(isToggle: Bool) {
        if isToggle {
            backgroundColor = .darkYellow
            layer.borderWidth = 0
        } else {
            backgroundColor = .white
            titleLabel.textColor = .black
            layer.borderWidth = 1
            layer.borderColor = UIColor.darkYellow.cgColor
        }
    }
    
    func configure(vm: SettingTitleViewModel) {
        settingTitleVM = vm
        titleLabel.text = vm.book.title
        setupToggleColor(isToggle: vm.book.isDaily)
    }
}
