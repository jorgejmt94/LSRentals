//
//  Singleton.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 27/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation


class Singleton {
    static let instance     = Singleton();
    private var apartments  = [Apartment]();
    private var mapPoints   = [MapAnnotation]();
    
    private init() {}
    
    static func getInstance() -> Singleton {
        
        return instance;
    }
    
    func setApartments(_ apartments: [Apartment]) {
        
        self.apartments = apartments;
    }
    
    func getApartments() -> [Apartment] {
        
        return apartments;
    }
    
    func setMapPoints(_ mapPoints: [MapAnnotation]) {
        
        self.mapPoints = mapPoints;
    }
    
    func getMapPoints() -> [MapAnnotation] {
        
        return mapPoints;
    }
}
