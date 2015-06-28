//
//  LibraryAPI.swift
//  Restriccion Vehicular
//
//  Created by RWBook Retina on 6/26/15.
//  Copyright (c) 2015 RABO IT. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
    
    private let _restriccionService : IRestriccionService
    //private let httpClient : HTTPClient
    private let _isOnline : Bool
    
    class var sharedInstance : LibraryAPI{
        struct Singleton {
            
            static let instance  = LibraryAPI(restriccionService: RestriccionService(), onlineStatus: true)
        }
        return Singleton.instance
    }

    
    init(restriccionService: IRestriccionService, onlineStatus: Bool){
        self._restriccionService = restriccionService
        self._isOnline = onlineStatus
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func getRestriccionActual() -> Restriccion {
        return _restriccionService.getRestriccionActual()
    }
    
    
}
