//
//  TaskTableViewCell.swift
//  SimpleCoreData
//
//  Created by iwritecode on 4/4/16.
//  Copyright © 2016 sojiwritescode. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    var taskDescription: String = "" {
        willSet(taskDescription) {
            self.textLabel?.text = taskDescription
        }
    }
    
}
