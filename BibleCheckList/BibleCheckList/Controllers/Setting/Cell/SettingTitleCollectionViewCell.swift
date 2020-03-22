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
    private var isToggled = false
    private var settingTitleVM: SettingTitleViewModel?
    
    func toggle() {
        isToggled = !isToggled
        setupToggleColor(isToggled: isToggled)
        settingTitleVM?.changeIsDaily(on: isToggled)
    }
    
    func configure(vm: SettingTitleViewModel) {
        settingTitleVM = vm
        titleLabel.text = vm.book.title
        setupToggleColor(isToggled: vm.book.isDaily)
    }
    
    private func setupToggleColor(isToggled: Bool) {
        if isToggled {
            backgroundColor = .darkYellow
            layer.borderWidth = 0
        } else {
            backgroundColor = .white
            titleLabel.textColor = .black
            layer.borderWidth = 1
            layer.borderColor = UIColor.darkYellow.cgColor
        }
    }
}
