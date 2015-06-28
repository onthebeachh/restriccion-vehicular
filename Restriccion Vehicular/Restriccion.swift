//
//  Restriccion.swift
//  Restriccion Vehicular
//
//  Created by RWBook Retina on 6/26/15.
//  Copyright (c) 2015 RABO IT. All rights reserved.
//

import UIKit

class Restriccion: NSObject {
    
    var restriccionSinSello: String
    var restriccionConSello: String
    var fecha: NSDate
    var estado: Bool
    
    override init(){
        
        restriccionConSello = String()
        restriccionSinSello = String()
        fecha = NSDate()
        estado = true
        
        super.init()
       
    }
    
}
