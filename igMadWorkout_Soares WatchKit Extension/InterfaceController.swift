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
    @IBOutlet var messageLabel: WKInterfaceLabel!
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
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        //-----------
        // Message du téléphone
        let value = message["Message"] as? String
        conversation += value!
        //-----------
        DispatchQueue.main.async { () -> Void in
            // Affichage sur montre
            self.messageLabel.setText(self.conversation)
        }
        //-----------
        replyHandler(["Message" : conversation])
        //-----------
    }
    //--------------------------------------------------
    func sendMessage() {
        presentTextInputController(withSuggestions: ["Bonjour"], allowedInputMode: WKTextInputMode.plain,
                                   completion: {(results) -> Void in
                                    if results != nil && results!.count > 0 {
                                        let aResult = results?[0] as? String
                                        self.conversation += "Watch : \(aResult!)\n\n"
                                        self.messageLabel.setText(self.conversation)
                                        self.session.sendMessage(["Message" : self.conversation],
                                                                 replyHandler: {replyMessage in}, errorHandler: {error in print(error)})
                                    }
        })
    }
    //--------------------------------------------------
   
}
