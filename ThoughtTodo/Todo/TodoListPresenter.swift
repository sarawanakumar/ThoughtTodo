//
//  TodoListPresenter.swift
//  ThoughtTodo
//
//  Created by Saravanakumar S on 13/07/23.
//

import Foundation

class TodoListPresenter {
    
    private weak var todoListView: TodoListView?
    
    init(todoListView: TodoListView?) {
        self.todoListView = todoListView
    }
    
    func presentTodoItems(todos: [Todo]) {
//        todoListView?.updateView(viewModel: todos.mapToViewModel())
//        todoListView?.updateView(withSections: todos)
        let todoViewModel = todos.mapToViewModel()
        
        let pendingTodosModel = todoViewModel.filter({ !$0.isComplete })
        let completedTodosModel = todoViewModel.filter({ $0.isComplete })
        
        todoListView?.updateView(withSections: [
            .init(sectionName: "Pending", items: pendingTodosModel),
            .init(sectionName: "Completed", items: completedTodosModel)
        ])
    }
}

extension Array where Element == Todo {
    
    func mapToViewModel() -> [TodoViewModel] {
        map { todoItem in
                .init(
                    id: todoItem.id,
                    name: todoItem.name,
                    date: DateUtility.string(fromDate: todoItem.date),
                    isComplete: todoItem.complete
                )
        }
    }
}

class DateUtility {
    
    static func string(fromDate date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        
        return df.string(from: date)
    }
}
