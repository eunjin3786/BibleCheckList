//
//  CheckListViewController.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit


class CheckListViewController: UIViewController {
    
    let books = RealmManager.shared.getAllBooks()
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
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewCells[indexPath.row]
        return cell
    }
    
    func setTableView(){
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setTableViewCells(){
        for book in books{
            let cell = CheckListTableViewCell.instanceFromNib(book)
            tableViewCells.append(cell)
        }
    }
    
}


extension CheckListViewController:UITableViewDelegate{
    
}
