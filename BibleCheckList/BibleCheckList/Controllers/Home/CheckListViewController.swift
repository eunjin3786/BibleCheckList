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
    
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    @IBAction func categorySegmentedControlAction(_ sender: Any) {
        setTableViewCells(books:getBooksOfCategory())
    }
    
    func getBooksOfCategory()->[Book]{
        
        let selectedIndex = categorySegmentedControl.selectedSegmentIndex
        if let title = categorySegmentedControl.titleForSegment(at: selectedIndex){
           let books = RealmManager.shared.getBooksOfCategory(category: title)
           return books
        }
        
        return []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setTableViewCells(books:getBooksOfCategory())
        // category -> tableviewcells -> tableview reload
    }
    
}

extension CheckListViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewCells[indexPath.row]
        return cell
    }
    
    func setTableView(){
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setTableViewCells(books:[Book]){
        tableViewCells = []
        for book in books{
            let cell = CheckListTableViewCell.instanceFromNib(book)
            tableViewCells.append(cell)
        }
        
        tableView.reloadData()
    }
    
}


extension CheckListViewController:UITableViewDelegate{
    
}
