import UIKit

class TodoListViewController: UITableViewController {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Todos.plist")
    var itemArray = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTodos()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            let todo = Todo()
            todo.title = textField.text!
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
        do {
            let data = try Data(contentsOf: dataFilePath!)
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Todo].self, from: data)
            } catch(let decodeError) {
                print("Error decoding item array: \(decodeError)")
            }
        } catch(let error) {
            print("Error retrieving item array: \(error)")
        }
    }

    func persistTodos() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch(let error) {
            print("Error encoding item array: \(error)")
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
