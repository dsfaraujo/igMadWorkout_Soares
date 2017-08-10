//
//  InterfaceController.swift
//  igMadWorkout_Soares WatchKit Extension
//
//  Created by eleves on 2017-07-17.
//  Copyright © 2017 Diana. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var session : WCSession!
    //-----------
    var conversation: String = ""
    //--------------------------------------------------
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    //--------------------------------------------------
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
    }
    //--------------------------------------------------
    override func didDeactivate() {
        super.didDeactivate()
    }
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..code
    }

   
}
