//
//  Singleton.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 27/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation


class Singleton {
    static let instance = Singleton();
    private var apartments = [Int: Apartment]();
    
    private init() {}
    
    static func getInstance() -> Singleton {
        
        return instance;
    }
    
    func setApartments(_ apartments: [Int: Apartment]) {
        
        self.apartments = apartments;
    }
    
    func getApartments() -> [Int: Apartment] {
        
        return apartments;
    }
}
