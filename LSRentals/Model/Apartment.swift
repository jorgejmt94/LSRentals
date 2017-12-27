//
//  Apartment.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 27/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation

struct Apartment: Codable {
    
    let identifier:     Int;
    let name:           String;
    let info:           String;
    let location:       Location;
    let images:         Images;
    let available:      Bool;
    let maxCapacity:    Int;
    let maxDays:        Int;
    
    enum CodingKeys: String, CodingKey {
        
        case identifier;
        case name;
        case info;
        case location;
        case images;
        case available;
        case maxCapacity = "maximum_capacity";
        case maxDays     = "maximum_days";
    }
}



struct Location: Codable {
    
    let address:    String;
    let latitude:   Double;
    let longitude:  Double;
}

struct Images: Codable {
    
    let main:   String;
    let others: [String];
}
