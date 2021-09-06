import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    let realm = try! Realm()
    var todos: Results<Todo>?

    var selectedCategory: TodoCategory? {
        didSet {
            loadTodos()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            if let todoCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let todo = Todo()
                        todo.title = textField.text!
                        todoCategory.todos.append(todo)
                    }
                } catch(let error) {
                    print("There was an error saving the todo: \(error)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func loadTodos() {
        todos = selectedCategory?.todos.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos?.count ?? 0 == 0 ? 1 : todos!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell")!
        if let todo = todos?.count ?? 0 == 0 ? nil : todos?[indexPath.row] {
            cell.textLabel?.text = todo.title
            cell.accessoryType = todo.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let todo = todos?.count ?? 0 == 0 ? nil : todos?[indexPath.row] {
            do {
                try realm.write {
                    todo.done = !todo.done
                }
            } catch(let error) {
                print("Error updating todo item: \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        todos = selectedCategory?.todos.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadTodos()
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
