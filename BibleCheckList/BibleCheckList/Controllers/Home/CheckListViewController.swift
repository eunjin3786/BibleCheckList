//
//  CheckListViewController.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit


class CheckListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var tableViewCells:[UITableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setTableViewCells()
    }
    
}

extension CheckListViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewCells[indexPath.row]
    }
    
    func setTableView(){
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setTableViewCells(){
        tableViewCells = [CheckListTableViewCell.instanceFromNib(),
                          CheckListTableViewCell.instanceFromNib(),
                          CheckListTableViewCell.instanceFromNib(),
                          CheckListTableViewCell.instanceFromNib(),
                          CheckListTableViewCell.instanceFromNib()]
    }
    
}


extension CheckListViewController:UITableViewDelegate{
    
}
