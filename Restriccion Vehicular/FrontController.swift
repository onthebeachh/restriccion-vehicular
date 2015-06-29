//
//  FrontController.swift
//  Restriccion Vehicular
//
//  Created by RWBook Retina on 6/26/15.
//  Copyright (c) 2015 RABO IT. All rights reserved.
//

import UIKit
import Parse
import Bolts

class FrontController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBAction func FacebookLogin(sender: AnyObject) {

        var permissions = ["public_profile"]
        
       
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let push = PFPush()
        push.setMessage("Tests de envio de notificaciones push")
        push.sendPushInBackground()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
