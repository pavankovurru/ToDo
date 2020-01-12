//
//  ViewController.swift
//  ToDo
//
//  Created by pavan Kovurru on 1/10/20.
//  Copyright © 2020 pavan Kovurru. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var itemArray = ["One","Two","Three"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Getting data from user defaults
        if let data = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = data
        }

    }
    
    //MARK:- TABLE VIEW DATA SOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierToDoList, for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK:- TABLE VIEW DELEGATE METHODS

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK:- ADD ITEMS
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        //add action
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen when user clicks on add action item
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
            
            //Setting data with user defaults
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        }
        
        //add text field
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        //add action to alert and present it
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    


}

