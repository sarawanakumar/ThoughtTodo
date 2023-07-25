//
//  TodoViewModel.swift
//  ThoughtTodo
//
//  Created by Saravanakumar S on 13/07/23.
//

import Foundation

struct TodoViewModel {
    let id: String
    let name: String
    let date: String
    let isComplete: Bool
}

struct TodoSectionViewModel {
    let sectionName: String
    let items: [TodoViewModel]
}
