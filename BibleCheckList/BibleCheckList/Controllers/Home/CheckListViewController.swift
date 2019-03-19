//
//  CheckListViewController.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 22/10/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CheckListViewController: UIViewController {
    
    private var booksVM = BooksViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBAction func categorySegmentedControlAction(_ sender: Any) {
        setupSegmentedControl()
    }
    
    let bag = DisposeBag()
    
    private func setupSegmentedControl() {
        let selectedIndex = categorySegmentedControl.selectedSegmentIndex
        if let title = categorySegmentedControl.titleForSegment(at: selectedIndex){
            booksVM.setupBooksOfCategory(name: title)
            scrollToTop()
        }
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CheckListTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckListTableViewCell")
        tableView.rx.setDelegate(self).disposed(by: bag)
    }
    
    private func scrollToTop(){
        if booksVM.books.value.count == 0 { return }
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindTableView()
        setupSegmentedControl()
    }
    
    private func bindTableView() {
        booksVM.books.asObservable().bind(to: tableView.rx.items) { (tableView, index, book) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListTableViewCell") as? CheckListTableViewCell else { return UITableViewCell() }
            let book = self.booksVM.books.value[index]
            cell.configure(book: book)
            return cell
        }.disposed(by: bag)
    }
}

extension CheckListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let finish = finishAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [finish])
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let clear = clearAction(at:indexPath)
        return UISwipeActionsConfiguration(actions: [clear])
    }
    
    private func finishAction(at indexPath: IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            let book = self.booksVM.books.value[indexPath.row]
            if let cell = self.tableView.cellForRow(at: indexPath) as? CheckListTableViewCell {
                cell.bookVM.changeAllRead(isRead: true)
                cell.configure(book: book)
            }
        }
        action.backgroundColor = UIColor.darkYellow
        action.image = UIImage(named: "finish")
        return action
    }
    
    private func clearAction(at indexPath:IndexPath) -> UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            
            guard let `self` = self else{return}
            let book = self.booksVM.books.value[indexPath.row]
            if let cell = self.tableView.cellForRow(at: indexPath) as? CheckListTableViewCell {
                cell.bookVM.changeAllRead(isRead: false)
                cell.configure(book: book)
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

