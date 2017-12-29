//
//  ApartmentTabBarController.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 26/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import UIKit
import Alamofire

public class ApartmentTabBarController : UITabBarController, UINavigationControllerDelegate {
    

    override public func viewDidLoad() {
        super.viewDidLoad();

    }
    @IBAction func logOutButton(_ sender: Any) {
        UserConfig.deleteUser();
        self.performSegue(withIdentifier: "logOut", sender: self);
    }
    
}
