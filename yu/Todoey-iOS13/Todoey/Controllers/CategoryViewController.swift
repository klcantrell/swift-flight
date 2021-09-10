import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    let realm = try! Realm()
    var categoriesArray: Results<TodoCategory>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableView.fillerRowHeight = 80.0
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            let category = TodoCategory()
            category.name = textField.text!
            category.rowColor = UIColor.randomFlat().hexValue()
            self.save(category)
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Data manipulation methods

    func loadCategories() {
        categoriesArray = realm.objects(TodoCategory.self)
    }

    func save(_ todoCategory: TodoCategory) {
        do {
            try realm.write {
                realm.add(todoCategory)
            }
        } catch(let error) {
            print("There was an error saving categories: \(error)")
        }
        tableView.reloadData()
    }
    
    override func updateDataModel(at indexPath: IndexPath) {
        if let category = self.categoriesArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(category.todos)
                    self.realm.delete(category)
                }
            } catch(let error) {
                print("Error deleting category: \(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoriesArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let category = categoriesArray?[indexPath.row]
        let cellText = category?.name ?? "No categories added yet"
        cell.textLabel?.text = cellText
        cell.backgroundColor = UIColor(hexString: category?.rowColor ?? UIColor.randomFlat().hexValue())
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CategoryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationViewController.selectedCategory = categoriesArray?.count ?? 0 == 0 ? nil : categoriesArray?[indexPath.row]
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard categoriesArray?.count ?? 0 > 0 else {
            return
        }
        performSegue(withIdentifier: "goToTodos", sender: self)
    }
}
