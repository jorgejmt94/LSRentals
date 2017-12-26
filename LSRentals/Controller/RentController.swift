//
//  RentController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit

class RentController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: cargar info apartament (nombre y direccion, se podria hacer pasandola desde el anterior)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        //TODO: NO VA
        self.navigationController?.popViewController(animated: true);

    }
    
    @IBAction func rentButton(_ sender: Any) {
        //TODO: envair reserva
        
        //anem a les pantallas dels tabs //TODO: NO VA
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
