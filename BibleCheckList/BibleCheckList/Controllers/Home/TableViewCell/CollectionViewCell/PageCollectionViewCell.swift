//
//  PageCollectionViewCell.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pageNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func toggle(isRead:Bool){
        if isRead{
            self.backgroundColor = UIColor.darkYellow
        } else {
            self.backgroundColor = UIColor.whiteGray
        }
    }

}
