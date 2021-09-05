import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoriesArray = [TodoCategory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            let category = TodoCategory(context: self.context)
            category.name = textField.text!
            self.categoriesArray.append(category)
            self.persistCategories()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func loadCategories(with request: NSFetchRequest<TodoCategory> = TodoCategory.fetchRequest()) {
        do {
            categoriesArray = try context.fetch(request)
        } catch(let error) {
            print("There was an error retrieving categories: \(error)")
        }
    }

    func persistCategories() {
        do {
            try context.save()
        } catch(let error) {
            print("There was an error saving categories: \(error)")
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoriesArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        cell.textLabel?.text = category.name
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CategoryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationViewController.selectedCategory = categoriesArray[indexPath.row]
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToTodos", sender: self)
    }
}
