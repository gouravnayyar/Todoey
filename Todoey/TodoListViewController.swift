//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Gourav Nayyar on 09/08/18.
//  Copyright © 2018 Gourav Nayyar. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgon"]

    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


        if let items = self.defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }

    }

    // MARK - Tableview Datasource method

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }

    // MARK - Tableview Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }


        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK - Add New Items 
    @IBAction func addButtonPressed(_ sender: Any) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // Add action when user click on the button
            if let item = textField.text {
                self.itemArray.append(item)
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            }
            // Should animate the table view (add row with animatio on index path)
            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }


}

