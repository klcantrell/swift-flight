import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    let realm = try! Realm()
    var todos: Results<Todo>?

    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedCategory: TodoCategory? {
        didSet {
            loadTodos()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .singleLine
        if #available(iOS 15.0, *) {
            tableView.fillerRowHeight = 80.0
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if let selectedCategoryColor = selectedCategory?.rowColor,
           let selectedCategoryTitle = selectedCategory?.name {
            if let backgroundColor = UIColor(hexString: selectedCategoryColor) {
                let constrastColor = ContrastColorOf(backgroundColor, returnFlat: true)
                navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = backgroundColor
                navigationController?.navigationBar.standardAppearance.backgroundColor = backgroundColor
                navigationController?.navigationBar.tintColor = constrastColor
                searchBar?.barTintColor = backgroundColor
                navigationController?.navigationBar.scrollEdgeAppearance?.largeTitleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: constrastColor
                ]
                navigationController?.navigationBar.standardAppearance.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: constrastColor
                ]
            }
            title = selectedCategoryTitle
        }
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
    
    // MARK: - Data manipulation methods
    
    func loadTodos() {
        todos = selectedCategory?.todos.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    override func updateDataModel(at indexPath: IndexPath) {
        if let todo = todos?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(todo)
                }
            } catch(let error) {
                print("Error deleting todo: \(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let todo = todos?[indexPath.row] {
            cell.textLabel?.text = todo.title
            cell.accessoryType = todo.done ? .checkmark : .none
            if let color = UIColor(hexString: selectedCategory!.rowColor)?
                .darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todos!.count)) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
        } else {
            cell.textLabel?.text = "No items added"
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let todo = todos?[indexPath.row] {
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
