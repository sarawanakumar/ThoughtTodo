//
//  TodoCell.swift
//  ThoughtTodo
//
//  Created by Saravanakumar S on 13/07/23.
//

import UIKit

protocol TodoCellDelegate: AnyObject {
    func didChangeItemState(id: String, isOn: Bool)
}

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var completionToggle: UISwitch!
    var id: String?
    weak var delegate: TodoCellDelegate?
    
    func configureCell(model: TodoViewModel) {
        id = model.id
        nameLabel.text = model.name
        dateLabel.text = model.date
        completionToggle.isOn = model.isComplete
    }
    
    @IBAction func didToggleTodo(_ sender: UISwitch) {
        delegate?.didChangeItemState(id: id ?? "0", isOn: sender.isOn)
    }
}
