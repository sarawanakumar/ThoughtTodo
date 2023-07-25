//
//  TodoListViewController.swift
//  ThoughtTodo
//
//  Created by Saravanakumar S on 13/07/23.
//

import UIKit

protocol TodoListView: AnyObject {
    func updateView(viewModel: [TodoViewModel])
    func updateView(withSections viewModel: [TodoSectionViewModel])
    var todoInteractor: TodoListInteractor? { get set }
}

class TodoListViewController: UIViewController, TodoListView {
    
    var todoInteractor: TodoListInteractor?
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: [TodoSectionViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "TodoCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todoInteractor?.start()
    }
    
    func updateView(viewModel: [TodoViewModel]) {
//        self.viewModel = viewModel
//        tableView.reloadData()
    }
    
    func updateView(withSections viewModel: [TodoSectionViewModel]) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

extension TodoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell else {
            return .init()
        }
        
        let cellViewModel = viewModel[indexPath.section].items[indexPath.row]
        cell.configureCell(model: cellViewModel)
        cell.delegate = self
        
        return cell
    }
}

extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel[section].sectionName
    }
}

extension TodoListViewController: TodoCellDelegate {
    
    func didChangeItemState(id: String, isOn: Bool) {
        todoInteractor?.updateItem(withId: id, toComplete: isOn)
    }
}
