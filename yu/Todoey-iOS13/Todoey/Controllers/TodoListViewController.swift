import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTodos()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            let todo = Todo(context: self.context)
            todo.title = textField.text!
            todo.done = false
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

    func loadTodos() {
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        do {
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

// // MARK: - UITableViewDelegate

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = itemArray[indexPath.row]
        todo.done = !todo.done
        persistTodos()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
