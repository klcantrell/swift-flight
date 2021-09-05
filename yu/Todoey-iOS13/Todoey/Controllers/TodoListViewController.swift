import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var itemArray = [Todo]()

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
            let todo = Todo(context: self.context)
            todo.title = textField.text!
            todo.done = false
            todo.parentCategory = self.selectedCategory
            self.itemArray.append(todo)
            self.persistTodos()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func loadTodos(with request: NSFetchRequest<Todo> = Todo.fetchRequest(), predicate: NSPredicate? = nil) {
        do {
            let categoryPredicate = NSPredicate(format: "parentCategory.name == %@", selectedCategory!.name!)
            if let additionalPredicate = predicate {
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            } else {
                request.predicate = categoryPredicate
            }
            itemArray = try context.fetch(request)
        } catch(let error) {
            print("There was an error retrieving todos: \(error)")
        }
    }

    func persistTodos() {
        do {
            try context.save()
        } catch(let error) {
            print("There was an error saving todos: \(error)")
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell")!
        cell.textLabel?.text = todo.title
        cell.accessoryType = todo.done ? .checkmark : .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = itemArray[indexPath.row]
        todo.done = !todo.done
        persistTodos()
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
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadTodos(with: request)
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
