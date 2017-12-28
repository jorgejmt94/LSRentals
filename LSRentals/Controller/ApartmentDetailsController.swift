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
    public var apartmentIdSegue: Int!;
    private let singleton = Singleton.getInstance();
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        let apartment = singleton.getApartment(key: self.apartmentIdSegue);
        self.apartmentNameLabel.text = apartment!.name;
        self.apartmentAddressLabel.text = apartment!.location.address;
        self.apartmentCapacityLabel.text = String(apartment!.maxCapacity);
        
        
        //TODO: cargar info apartament        
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Rent" {
            
            let nextView = segue.destination as? RentController;
            nextView?.aparmentId = apartmentIdSegue;
        }
    }
    
    @IBAction func rentButton(_ sender: Any) {
        self.performSegue(withIdentifier: "Rent", sender: self);
    }
    
    
    /*@IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);

    }*/
    
    
}
