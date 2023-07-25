//
//  TodoDataManager.swift
//  ThoughtTodo
//
//  Created by Saravanakumar S on 13/07/23.
//

import Foundation

class TodoDataManager {
    
    var todos: [Todo] = []
    
    private func readData() -> [Todo] {
        if self.todos.isEmpty {
            let fileUrl = Bundle.main.url(forResource: "data", withExtension: ".json")
            let data = (try! String(contentsOf: fileUrl!)).data(using: .utf8)
            let todos = try! JSONDecoder().decode(Array<Todo>.self, from: data!)
            self.todos = todos
            return todos
        } else {
            return self.todos
        }
    }
    
    func thoughtTodo(for date: TodoDate) -> [Todo] {
        let allTodos = readData()
        if date == .today {
            return allTodos.filter({ $0.date.isToday() })
        } else {
            return allTodos.filter({ !$0.date.isToday() })
        }
    }
    
    func updateTodo(withId id: String, isComplete: Bool) {
        guard let todo = todos.first(where: { $0.id == id }).map({ Todo(id: $0.id, name: $0.name, date: $0.date, complete: isComplete)}) else {
            return
        }
        
        todos.removeAll(where: {$0.id == id})
        todos.append(todo)
    }
}

enum TodoDate {
    case today
    case later
}

struct Todo: Decodable {
    let id: String
    let name: String
    let date: Date
    var complete: Bool
    
    mutating func setState(_ state: Bool) {
        complete = state
    }
}

extension Date {
    
    func isToday() -> Bool {
        Calendar.current.isDateInToday(self)
    }
    
    func isLaterThanToday() -> Bool {
        let startOfDate = Calendar.current.startOfDay(for: self)
        let startOfToday = Calendar.current.startOfDay(for: .init())
        
        return startOfDate > startOfToday
    }
}
