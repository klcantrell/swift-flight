import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    var categoriesArray: Results<TodoCategory>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            let category = TodoCategory()
            category.name = textField.text!
            self.save(category)
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

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
}

// MARK: - UITableViewDataSource

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowCount = categoriesArray?.count {
            return rowCount == 0 ? 1 : rowCount
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellText = categoriesArray?.count ?? 0 == 0 ? "No categories added yet" : categoriesArray?[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        cell.textLabel?.text = cellText
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
