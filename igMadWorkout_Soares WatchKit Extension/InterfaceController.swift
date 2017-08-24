//
//  InterfaceController.swift
//  igMadWorkout_Soares WatchKit Extension
//
//  Created by eleves on 2017-07-17.
//  Copyright © 2017 Diana. All rights reserved.
//
//=================================
import WatchKit
import Foundation
import WatchConnectivity
//=================================
//classe pour la connexion avec l'interface de la montre
class InterfaceController: WKInterfaceController, WCSessionDelegate {
    //--------------------------------------------------
    @IBOutlet var table: WKInterfaceTable!
    //--------------------------------------------------
    var data: [String : String] = [:]
    var dates: [String] = []
    var workouts: [String] = []
    //-----------
    var session : WCSession!
   //--------------------------------------------------
    func userDefaultManager() {
        if UserDefaults.standard.object(forKey: "data") == nil {
            UserDefaults.standard.set(data, forKey: "data")
        }
        else{
            data = UserDefaults.standard.object(forKey: "data") as! [String: String]
        }
    }
    //--------------------------------------------------
    //fonction refresh la tableView de la montre
    func tableRefresh(){
        table.setNumberOfRows(data.count, withRowType: "row")
        for index in 0..<table.numberOfRows{
            let row = table.rowController(at: index) as! tableRowController
            row.dates.setText(dates[index])
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    //--------------------------------------------------
    //fonction pour activer la session avec la montre
    override func willActivate() {
        //-----------
        super.willActivate()
        //-----------
        if (WCSession.isSupported()) {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        //-----------
        userDefaultManager()
        //-----------
        self.dates = Array(data.keys)
        self.workouts = Array(data.values)
        tableRefresh()
    }
    //--------------------------------------------------
    //fonction de arreter la connexion avec la montre
    override func didDeactivate() {
        super.didDeactivate()
    }
    //connexion avec l'apple watch
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..code
    }
    //fonction de activation des sessions de la montre
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        //-----------
        // Message du téléphone
        let value = message["Message"] as? [String : String]
        //-----------
        DispatchQueue.main.async { () -> Void in
           self.data = value!
            UserDefaults.standard.set(self.data, forKey: "data")
            self.dates = Array(value!.keys)
            self.workouts = Array(value!.values)
            self.tableRefresh()
            
        }
        //-----------
        //replyHandler(["Message" : conversation])
        //-----------
    }
    //--------------------------------------------------
    //fonction de mise à jour de la tableView dans la montre
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        self.pushController(withName: "page2", context: ["workout": workouts[rowIndex]])
    }
    //--------------------------------------------------
   
}
//=================================
