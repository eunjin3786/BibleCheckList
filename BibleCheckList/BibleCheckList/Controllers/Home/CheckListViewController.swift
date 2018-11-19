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
        tableView.scrollToRow(at:IndexPath(row: 0, section: 0), at: .top, animated: true)
        
    }
    
}


extension CheckListViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let important = importantAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [important])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let important = importantAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [important])
    }
    
    //https://www.youtube.com/watch?v=wUVfE8cY2Hw
    func importantAction(at inIndexPath:IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "테스트") { (action, view, completion) in
            
            print("액션")
        }
        action.backgroundColor = UIColor.darkYellow
        return action
    }
}
