//
//  CheckListTableViewCell.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit

class CheckListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    class func instanceFromNib()->CheckListTableViewCell{
        let cell = UINib(nibName: "CheckListTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CheckListTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    

}
