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
    
    @IBOutlet weak var apartmentNameLabel: UILabel!
    @IBOutlet weak var apartmentAddressLabel: UILabel!
    @IBOutlet weak var apartmentCapacityLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: cargar info apartament
    }
    
    
    @IBAction func rentButton(_ sender: Any) {
        self.performSegue(withIdentifier: "RentController", sender: self);
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);

    }
    
    
}
