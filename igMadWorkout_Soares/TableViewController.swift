//
//  TableViewController.swift
//  igMadWorkout_Soares
//
//  Created by eleves on 2017-08-15.
//  Copyright © 2017 Diana. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    var theDatabase: [String : [String : String]]!
    var theWorkout: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.theDatabase = Shared.sharedInstance.getDatabase("db")
        self.theWorkout = self.fillUpWorkoutArray(self.getDates()[Shared.sharedInstance.theRow])
    }
    
    func getDates() -> [String]{
        var tempArray = [""]
        for (a, _) in self.theDatabase{
            tempArray.append(a)
        }
        tempArray.remove(at: 0)
        return tempArray
    }
}
