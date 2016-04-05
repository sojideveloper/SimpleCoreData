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
    let attributeKey = "taskDescription"
    
    var taskList = [NSManagedObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(TaskViewController.addTask))

    }
    
    override func viewWillAppear(animated: Bool) {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: entityName)
        
        do {
            let results = try context.executeFetchRequest(request) as! [NSManagedObject]
            taskList = results 
        } catch {
            print("Could not execute fetch request:")
        }
    }
    
    func addTask() {
        let alert = UIAlertController(title: "Add a new task", message: "Enter the new task description below", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            if let alertTextField = alert.textFields![0] as? UITextField {
                self.saveTask(alertTextField.text!)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Enter task description..."
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func saveTask(taskToSave: String) {
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
        let taskDescription = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: context) 
        
        taskDescription.setValue(taskToSave, forKey: attributeKey)
        
        do {
            try context.save()
            taskList.append(taskDescription)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TaskTableViewCell
        let task = taskList[indexPath.row]
        cell.textLabel!.text = task.valueForKey(attributeKey) as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDel.managedObjectContext
            let request = NSFetchRequest(entityName: entityName)
            
            do {
                let results = try context.executeFetchRequest(request) as! [NSManagedObject]
                
                context.deleteObject(results[indexPath.row])
                taskList.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
                
            } catch {
                print("Could not delete item(s)")
            }
            
            do {
                try context.save()
            } catch {
                print("Could not save records after deletion")
            }
        }
    }
}

extension TaskViewController: UITableViewDelegate {
    
}
