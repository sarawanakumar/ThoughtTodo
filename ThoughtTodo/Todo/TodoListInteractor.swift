//
//  TodoListInteractor.swift
//  ThoughtTodo
//
//  Created by Saravanakumar S on 13/07/23.
//

import Foundation

class TodoListInteractor {
    
    let dataManager: TodoDataManager
    let presenter: TodoListPresenter
    let mode: TodoDate
    
    init(dataManager: TodoDataManager, presenter: TodoListPresenter, mode: TodoDate) {
        self.dataManager = dataManager
        self.presenter = presenter
        self.mode = mode
    }
    
    func start() {
        let todoItems = dataManager.thoughtTodo(for: mode)
        presenter.presentTodoItems(todos: todoItems)
    }
    
    func updateItem(withId id: String, toComplete: Bool) {
        dataManager.updateTodo(withId: id, isComplete: toComplete)
        start()
    }
}
