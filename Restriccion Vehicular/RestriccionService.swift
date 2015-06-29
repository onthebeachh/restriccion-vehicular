//
//  PersistencyManager.swift
//  Restriccion Vehicular
//
//  Created by RWBook Retina on 6/26/15.
//  Copyright (c) 2015 RABO IT. All rights reserved.
//

import UIKit
import Parse

class RestriccionService: NSObject, IRestriccionService {
    
    var restriccion: Restriccion
    
    override init(){
        restriccion = Restriccion()
    }
    
    func getRestriccionActual() -> Restriccion {
        getFromParse()
        return self.restriccion
    }
    
    func getFromParse() {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_sync(dispatch_get_global_queue(priority, 0)) {
            var query = PFQuery(className: "Restriccion")

            query.limit = 1
            query.orderByDescending("fecha")
            query.findObjectsInBackgroundWithBlock {
                (PFRestricciones: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                    if let PFRestricciones = PFRestricciones as? [PFObject] {
                        
                        for PFRestriccion in PFRestricciones {
                            
                            var numeros_sinsello = PFRestriccion["numeros_sinsello"] as? [Int]!
                            var numeros_consello = PFRestriccion["numeros_consello"] as? [Int]!
                            
                            self.restriccion.restriccionSinSello = (numeros_sinsello!.count>0) ? numeros_sinsello!.description : "Sin Restricción"
                            self.restriccion.restriccionConSello = (numeros_consello!.count>0) ? numeros_consello!.description : "Sin Restricción"
                            
                            self.restriccion.fecha = (PFRestriccion["fecha"] as? NSDate!)!
                            self.restriccion.estado = (PFRestriccion["estado"] as? Bool)!
                        }
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("actualizarRestriccionNotification", object: self, userInfo: ["restriccion":self.restriccion])
                } else {
                    println("Error: \(error!) \(error!.userInfo!)")
                }
            }
           
            }
 
        }
    }
    
    func createRestriccion(numeros_sinsello: [Int], numeros_consello: [Int]){
        var restriccion = PFObject(className:"Restriccion")
        restriccion["numeros_sinsello"] = numeros_consello
        restriccion["numeros_consello"] = numeros_sinsello
        restriccion["estado"] = true
        restriccion["fecha"] = NSDate()
        
        restriccion.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("restriccion creada")
            } else {

            }
        }
    
    }
    
    func getFromWeb() {
        
        var urlString = "http://www.uoct.cl/restriccion-vehicular"
        var url = NSURL(string: urlString)
        var session: NSURLSession = NSURLSession()
        
        if(url != nil){
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                var restriccion: Restriccion
                if error == nil {
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    var urlContentArray = urlContent.componentsSeparatedByString("<div class=\"restriction\"><h3>")
                    
                    if urlContentArray.count > 0 {
                        var sinSelloArray = urlContentArray[1].componentsSeparatedByString("</h3>")
                        var conSelloArray = urlContentArray[2].componentsSeparatedByString("</h3>")
                        
                        //self.restriccion.restriccionSinSello = sinSelloArray[0] as! String
                        //self.restriccion.restriccionConSello = conSelloArray[0] as! String
                        
                        /*NSNotificationCenter.defaultCenter().postNotificationName("actualizarRestriccionNotification", object: self, userInfo: ["restriccion":restriccion])*/
                    }
                }
            })
            task.resume()
        
    
    }
}
