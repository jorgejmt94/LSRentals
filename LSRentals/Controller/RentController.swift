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
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var dateIn: UIDatePicker!
    @IBOutlet weak var dateOut: UIDatePicker!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var numberOfPeople: UITextField!
    
    
    @IBAction func stepperChanged(_ sender: Any) {
        numberOfPeople.text = Int(stepper.value).description;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        stepper.autorepeat = true;
        stepper.minimumValue = 0;
        stepper.maximumValue = 15;
        //TODO: cargar info apartament
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func rentButton(_ sender: Any) {
        //TODO: enviar reserva
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
