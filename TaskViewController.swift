//
//  TaskViewController.swift
//  SimpleCoreData
//
//  Created by iwritecode on 4/4/16.
//  Copyright © 2016 sojiwritescode. All rights reserved.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    let entityName = "Tasks"
    var taskList = [NSManagedObject]()
    var tempArray = ["Run", "Eat", "Shop", "Sleep", "Read"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("addTask"))
    }
    
    func addTask() {
        let alert = UIAlertController(title: "Add a new task", message: "Enter the new task description below", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            if let alertTextField = alert.textFields![0] as? UITextField {
                self.savetask(alertTextField.text!)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Enter task description..."
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func savetask(taskToSave: String) {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        let taskDescription = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: context)
        
        do {
            try context.save()
        } catch {
            print("Error: Could not save new task")
        }
    }
    
}

extension TaskViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        return cell
    }
    
}

extension TaskViewController: UITableViewDelegate {
    
}
