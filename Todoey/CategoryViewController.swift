//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gourav Nayyar on 11/08/18.
//  Copyright © 2018 Gourav Nayyar. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext



    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    // MARK: TableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        let category = categories[indexPath.row]

        cell.textLabel?.text = category.name
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        return cell
    }
    // MARK: Data Manipulation Method
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving the context, \(error)")
        }

        tableView.reloadData()
    }

    func loadCategories () {
        let request : NSFetchRequest<Category> = Category.fetchRequest()

        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }

        tableView.reloadData()
    }
    // MARK: Add New Categories

    @IBAction func addButtonPressed(_ sender: Any) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in

            if let name = textField.text {
                let newCategory = Category(context: self.context)
                newCategory.name = name
                self.categories.append(newCategory)
            }

            self.saveCategory()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    //TODO:  Table View Delegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController

        // Since this is only triggered from the didSelect row
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }

}
