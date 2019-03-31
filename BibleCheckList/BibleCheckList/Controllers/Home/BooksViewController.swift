//
//  CheckListViewController.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    private var books:[Book] = []
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    @IBAction func categorySegmentedControlAction(_ sender: Any) {
        setTableViewCells(books: getBooksOfCategory())
    }
    
    private func getBooksOfCategory()->[Book]{
        let selectedIndex = categorySegmentedControl.selectedSegmentIndex
        if let title = categorySegmentedControl.titleForSegment(at: selectedIndex){
            if title == "Daily" {
                return RealmManager.shared.getAllBooks().filter{ $0.isDaily == true }
            } else {
                return RealmManager.shared.getBooksOfCategory(category: title).filter{ $0.isDaily == false }
            }
        }
        return []
    }
    
    private func setTableView(){
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "BookTableViewCell")
    }
    
    private func setTableViewCells(books: [Book]){
        self.books = books
        tableView.reloadData()
        if books.count == 0 { return }
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setTableViewCells(books: getBooksOfCategory())
    }
}

extension BooksViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
        cell.book = books[indexPath.row]
        return cell
    }
    
}


extension BooksViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let finish = finishAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [finish])
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let clear = clearAction(at:indexPath)
        //let send = sendAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [clear])
    }
    
    private func finishAction(at indexPath:IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            
            let book = self.books[indexPath.row]
            RealmManager.shared.changeAllRead(title: book.title,isRead:true)
            
            let cell = self.tableView.cellForRow(at: indexPath) as! BookTableViewCell
            cell.book = book
            cell.collectionView.reloadData()
            
        }
        action.backgroundColor = UIColor.darkYellow
        action.image = UIImage(named: "finish")
        return action
    }
    
    private func clearAction(at indexPath:IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            
            let book = self.books[indexPath.row]
            RealmManager.shared.changeAllRead(title: book.title,isRead:false)
            
            let cell = self.tableView.cellForRow(at: indexPath) as! BookTableViewCell
            cell.book = book
            cell.collectionView.reloadData()
            
        }
        action.backgroundColor = UIColor.red
        action.image = UIImage(named: "refresh")
        return action
    }
    
    /*
    private func sendAction(at indexPath:IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            
        }
        action.backgroundColor = UIColor.lightMint
        action.image = UIImage(named: "send")
        return action
    }
    */
}

extension BooksViewController: SettingDelegate {
    func settingsDone() {
        setTableViewCells(books: getBooksOfCategory())
    }
}

extension BooksViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Setting" {
            prepareSegueForSettingViewController(segue: segue)
        }
    }
    
    private func prepareSegueForSettingViewController(segue: UIStoryboardSegue) {
        guard let vc = segue.destination as? SettingViewController else {
            fatalError("SettingViewController not found")
        }
        
        vc.delegate = self
    }
}

