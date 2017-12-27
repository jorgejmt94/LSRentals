//
//  RentController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit

class RentController: UIViewController {
    
    @IBOutlet weak var apartmentNameLabel: UILabel!
    @IBOutlet weak var apartmentAddressLabel: UILabel!
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: cargar info apartament
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        //TODO: NO VA
        
        print("here!");
        self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func rentButton(_ sender: Any) {
        //TODO: enviar reserva
        print("horo!");
        //anem a les pantallas dels tabs //TODO: NO VA
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
