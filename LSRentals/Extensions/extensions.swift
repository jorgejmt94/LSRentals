//
//  extensions.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 25/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func showDefaultAlertDialog(title: String, msg: String, buttonTitle: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert);
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil));
        
        self.present(alert, animated: true, completion: nil);
    }
}

// TODO: extension of class String to verify email address format
