//
//  ApartmentDetailsController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ApartmentDetailsController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: cargar info apartament
    }
    
    @IBAction func rentButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "rentController", sender: self);
    }
    
}
