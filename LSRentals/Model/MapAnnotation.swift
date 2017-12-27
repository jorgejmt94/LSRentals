//
//  MapAnnotation.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 27/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotation: MKPointAnnotation {
    
    init(coordinate: CLLocationCoordinate2D, title: String, info: String) {
        super.init();
        
        super.coordinate    = coordinate;
        super.title         = title;
        super.subtitle      = info;
    }
}
