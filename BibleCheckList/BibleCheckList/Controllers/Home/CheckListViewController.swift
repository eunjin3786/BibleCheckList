//
//  CheckListViewController.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit

class CheckListViewController: UIViewController {
    
    private var booksVM = BooksViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBAction func categorySegmentedControlAction(_ sender: Any) {
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        let selectedIndex = categorySegmentedControl.selectedSegmentIndex
        if let title = categorySegmentedControl.titleForSegment(at: selectedIndex){
            booksVM.setupBooksOfCategory(name: title)
            reloadTableView()
        }
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CheckListTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckListTableViewCell")
    }
    
    private func reloadTableView(){
        tableView.reloadData()
        if booksVM.books.count == 0 { return }
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSegmentedControl()
    }
}

extension CheckListViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksVM.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListTableViewCell", for: indexPath) as! CheckListTableViewCell
        let book = booksVM.books[indexPath.row]
        cell.configure(vm: BookViewModel(book: book))
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
    
    private func finishAction(at indexPath: IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            let book = self.booksVM.books[indexPath.row]
            let bookVM = BookViewModel(book: book)
            bookVM.changeAllRead(isRead: true)
            
            if let cell = self.tableView.cellForRow(at: indexPath) as? CheckListTableViewCell {
                cell.configure(vm: bookVM)
            }
        }
        action.backgroundColor = UIColor.darkYellow
        action.image = UIImage(named: "finish")
        return action
    }
    
    private func clearAction(at indexPath:IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            let book = self.booksVM.books[indexPath.row]
            let bookVM = BookViewModel(book: book)
            bookVM.changeAllRead(isRead: false)
            
            if let cell = self.tableView.cellForRow(at: indexPath) as? CheckListTableViewCell {
                cell.configure(vm: bookVM)
            }
        }
        action.backgroundColor = UIColor.red
        action.image = UIImage(named: "refresh")
        return action
    }
}

extension CheckListViewController: SettingDelegate {
    func settingsDone() {
        setupSegmentedControl()
    }
}

extension CheckListViewController {
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

