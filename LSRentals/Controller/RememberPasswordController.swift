//
//  RememberPasswordController.swift
//  LSRentals
//
//  Created by Jorge Melguizo Torres on 28/12/17.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit
class RememberPasswordController: UIViewController {
    @IBOutlet weak var mailLabel: UITextField!
    
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "PasswordRemembered", sender: self);
    }
    
    
    @IBAction func rememberButton(_ sender: Any) {
        self.performSegue(withIdentifier: "PasswordRemembered", sender: self);
    }
    
    
}
