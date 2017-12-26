//
//  WelcomeController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    @IBAction func accessButton(_ sender: Any) {
        self.performSegue(withIdentifier: "tabBarController", sender: self);

    }

    @IBAction func logOutButton(_ sender: Any) {
        
        //TODO: ESBORRAR CREDENCIALS LOGIN
    }
    
    
}
