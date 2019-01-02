//
//  CheckListViewController.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit

class CheckListViewController: UIViewController {
    
    private var books:[Book] = []
    @IBOutlet weak var tableView: UITableView!
    
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
    
    func setTableView(){
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "CheckListTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckListTableViewCell")
    }
    
    func setTableViewCells(books:[Book]){
        
        self.books = books
        tableView.reloadData()
        tableView.scrollToRow(at:IndexPath(row: 0, section: 0), at: .top, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setTableViewCells(books:getBooksOfCategory())
    }
    
}

extension CheckListViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListTableViewCell", for: indexPath) as! CheckListTableViewCell
        cell.book = books[indexPath.row]
        return cell
    }
    
}


extension CheckListViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let finish = finishAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [finish])
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let clear = clearAction(at:indexPath)
        //let send = sendAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [clear])
    }
    
    func finishAction(at indexPath:IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            
            let book = self.books[indexPath.row]
            RealmManager.shared.changeAllRead(title: book.title,isRead:true)
            
            let cell = self.tableView.cellForRow(at: indexPath) as! CheckListTableViewCell
            //let cell = self.tableViewCells[indexPath.row]
            cell.book = book
            cell.collectionView.reloadData()
            
        }
        action.backgroundColor = UIColor.darkYellow
        action.image = UIImage(named: "finish")
        return action
    }
    
    func clearAction(at indexPath:IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            
            let book = self.books[indexPath.row]
            RealmManager.shared.changeAllRead(title: book.title,isRead:false)
            
            let cell = self.tableView.cellForRow(at: indexPath) as! CheckListTableViewCell
            //let cell = self.tableViewCells[indexPath.row]
            cell.book = book
            cell.collectionView.reloadData()
            
        }
        action.backgroundColor = UIColor.red
        action.image = UIImage(named: "refresh")
        return action
    }
    
    /*
    func sendAction(at indexPath:IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            
        }
        action.backgroundColor = UIColor.lightMint
        action.image = UIImage(named: "send")
        return action
    }
    */
}
