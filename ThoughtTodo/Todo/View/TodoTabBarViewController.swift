//
//  TodoTabBarViewController.swift
//  ThoughtTodo
//
//  Created by Saravanakumar S on 13/07/23.
//

import UIKit

class TodoTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vcs = [getTodoListView(for: .today, item: .contacts), getTodoListView(for: .later, item: .favorites)]
        
        viewControllers = vcs.map({ UINavigationController(rootViewController: $0)})
//        setViewControllers(vcs, animated: true)
//        selectedIndex = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getTodoListView(for mode: TodoDate, item: UITabBarItem.SystemItem) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TodoListViewController") as? TodoListViewController
        let presenter = TodoListPresenter(todoListView: vc)
        let interactor = TodoListInteractor(dataManager: .init(), presenter: presenter, mode: mode)
        vc?.todoInteractor = interactor
        vc?.tabBarItem = .init(tabBarSystemItem: item, tag: 0)
        vc?.title = "Thought Todo"
        
        return vc!//UINavigationController(rootViewController: vc!)
    }
}
