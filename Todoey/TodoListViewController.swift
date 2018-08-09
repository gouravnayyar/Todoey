//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Gourav Nayyar on 09/08/18.
//  Copyright © 2018 Gourav Nayyar. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()

    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "Find Hero"
        itemArray.append(newItem2)

        if let items = self.defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }

    // MARK - Tableview Datasource method

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

    // MARK - Tableview Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done


        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }


        tableView.deselectRow(at: indexPath, animated: true)
        // animate only row
        tableView.reloadData()
    }

    // MARK - Add New Items 
    @IBAction func addButtonPressed(_ sender: Any) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // Add action when user click on the button
            if let item = textField.text {
                let newItem = Item()
                newItem.title = item
                self.itemArray.append(newItem)
            }

            self.defaults.set(self.itemArray, forKey: "ToDoListArray")

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

