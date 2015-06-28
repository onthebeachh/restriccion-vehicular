//
//  RestriccionController.swift
//  Restriccion Vehicular
//
//  Created by RWBook Retina on 6/25/15.
//  Copyright (c) 2015 RABO IT. All rights reserved.
//

import UIKit
import Parse

class RestriccionController: UIViewController {

    @IBOutlet var labelConSello: UILabel!
    @IBOutlet var labelSinSello: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var restriccion = LibraryAPI.sharedInstance.getRestriccionActual()
            NSNotificationCenter.defaultCenter().addObserver(self, selector:"reloadLabels:", name: "actualizarRestriccionNotification", object: nil)
            
           
        }
        
        
    }
    
    func reloadLabels(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        var restriccion = userInfo["restriccion"] as! Restriccion?
        dispatch_async(dispatch_get_main_queue()){
            self.labelSinSello.text = restriccion!.restriccionSinSello
            self.labelConSello.text = restriccion!.restriccionConSello
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
