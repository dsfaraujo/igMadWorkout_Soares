//
//  WorkoutController.swift
//  igMadWorkout_Soares
//
//  Created by eleves on 2017-08-17.
//  Copyright © 2017 Diana. All rights reserved.
//

import Foundation
import WatchKit

class WorkoutController: WKInterfaceController{
    
    @IBOutlet var displayLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?){
        super.awake(withContext: context)
        let temp = context as? [String : String]
        displayLabel.setText(temp?["workout"])
    }
}
