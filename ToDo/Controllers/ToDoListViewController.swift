//
//  ViewController.swift
//  ToDo
//
//  Created by pavan Kovurru on 1/10/20.
//  Copyright © 2020 pavan Kovurru. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    let realm = try! Realm()

    var toDoItems: Results<Item>?
    var selectedcategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- TABLE VIEW DATA SOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierToDoList, for: indexPath)
        
        if let item = toDoItems?[indexPath.row]{
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items added yet."
        }
        
        return cell
    }
    
    
    //MARK:- TABLE VIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row]{
            do{
                try self.realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Error updating Items done status \(error)")
            }
            
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK:- ADD ITEMS
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        //add action
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedcategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error saving new Items \(error)")
                }
            }
            
            self.tableView.reloadData()
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
    
    //MARK:- DATA MANUPULATION METHODS
    
    func loadItems(){
        toDoItems = selectedcategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
}


//MARK:- SEARCH BAR METHODS
extension ToDoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
               searchBar.resignFirstResponder()
            }
        }
    }
}

