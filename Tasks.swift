//
//  Tasks.swift
//  SimpleCoreData
//
//  Created by iwritecode on 4/3/16.
//  Copyright © 2016 sojiwritescode. All rights reserved.
//

import UIKit
import CoreData

@objc(Tasks)
class Tasks: NSManagedObject {
    
    @NSManaged var taskDescription: String
    
}
