//
//  WelcomeController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//
import Foundation
import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let userMail: String;
        userMail = UserConfig.getRememberUserName();
        //var userName = userMail.split(separator: "@");

        //welcomeLabel.text = "Welcome " + userName[0] + "!";
        welcomeLabel.text = userMail;
    }
    
    @IBAction func accessButton(_ sender: Any) {
        self.performSegue(withIdentifier: "tabBar", sender: self);

    }

    @IBAction func logOutButton(_ sender: Any) {
        
        UserConfig.deleteUser();
        self.performSegue(withIdentifier: "logIn", sender: self);
        //TODO: Kill view

    }
    
    
}
