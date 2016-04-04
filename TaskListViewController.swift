//
//  TaskListViewController.swift
//  SimpleCoreData
//
//  Created by iwritecode on 4/3/16.
//  Copyright © 2016 sojiwritescode. All rights reserved.
//

import UIKit
import CoreData

class TaskListViewController: UIViewController {
    
    var tempArray = ["Run", "Eat", "Shop", "Sleep", "Read"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel!.text = tempArray[indexPath.row]
        
        return cell
    }
    
}

extension TaskListViewController: UITableViewDelegate {
    
}

