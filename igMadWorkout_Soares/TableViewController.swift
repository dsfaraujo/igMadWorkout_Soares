//
//  TableViewController.swift
//  igMadWorkout_Soares
//
//  Created by eleves on 2017-08-15.
//  Copyright © 2017 Diana. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    // ============================
    var theDatabase: [String : [String : String]]!
    var theWorkout: [String]!
    // ============================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.theDatabase = Shared.sharedInstance.getDatabase("db")
        self.theWorkout = self.fillUpWorkoutArray(self.getDates()[Shared.sharedInstance.theRow])
    }
    // ============================
    func getDates() -> [String]{
        var tempArray = [""]
        for (a, _) in self.theDatabase{
            tempArray.append(a)
        }
        tempArray.remove(at: 0)
        return tempArray
    }
    // ============================
    func fillUpWorkoutArray(_ theDate: String) -> [String] {
        var arrToReturn: [String] = []
        for (a, b) in self.theDatabase {
            if a == theDate {
                for c in b {
                    for (d, e) in c {
                        arrToReturn.append("[\(e)] : \(d)")
                    }
                }
            }
        }
        return arrToReturn
    }
    // ============================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // ============================
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    // ============================
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.textLabel!.font = UIFont(name: "Caviar Dreams", size: 18.0)
        cell.textLabel!.text = self.theWorkout[indexPath.row]
        tableView.backgroundColor = UIColor.colorWithRedValue(redValue: 63, greenValue:92, blueValue: 255, alpha: 1)
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    // ============================
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // ============================
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.theWorkout.remove(at: indexPath.row)
            self.deleteFromDatabase(self.getDates()[Shared.sharedInstance.theRow], indexToDelete: indexPath.row)
            tableView.deleteRows(at: <#T##[IndexPath]#>, with: .fade)
        }
    }
    

    
}
