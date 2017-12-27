//
//  LoginController.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 23/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import UIKit
import Foundation

class LoginController: UIViewController, RequestProtocol {

    @IBOutlet private weak var loginText: UITextField!;
    @IBOutlet private weak var passText: UITextField!;
    
    
    @IBAction private func onLoginPressed() {
        
        // TODO: validate parameters
        let request = HttpRequest();
        
        do {
            try request.send(
                url: WSRentals.getWebServiceURL(function: WSRentals.FUNC_LOGIN),
                requestType: "POST",
                handler: self
            );
            
        } catch {
            // we must show the alert on the UI Thread or the app will crash
            // as explained here --> https://stackoverflow.com/questions/44093353/i-cant-use-alert-//inside-response-for-request-in-swift-3
            DispatchQueue.main.async {
                self.showDefaultAlertDialog(title: "Network error",
                                        msg: "An error happened while processing the request.",
                                        buttonTitle: "Accept"
                );
            }
        }
    }

    func getParameters() -> ([String : Any]) {
        
        let params : [String: String] = [
            
            "username": loginText.text!,
            "password": passText.text!
        ];

        return params;
    }
    
    func onResponse(responseData: [String: Any]) {

        let success = responseData["succeed"] as? Int;
        
        if success == 1 {   // request was OK
            
            let tkn = responseData["token"] as? String;
            DispatchQueue.main.async {
                self.showDefaultAlertDialog(title: "OK!", msg: "Just to know everything ok :) Token: \(tkn!)", buttonTitle: "Continue");
                // we must save the user data to autolog the user on next uses
                UserConfig.rememberUser(login: self.loginText.text!, token: tkn!);
                
                WSRentals.setToken(tkn: tkn!);
                self.performSegue(withIdentifier: "login_success", sender: self);
            }
        }
        else {  // an error happened with the data provided by the user
            DispatchQueue.main.async {
                self.showDefaultAlertDialog(title: "Authentication error", msg: "The email and/or password provided are incorrects. Please, try again.", buttonTitle: "Accept");
            }
        }        
    }
    
    func onError(msg: String) {
        
        print(msg);
    }
    
    @IBAction func rememberPasswordButton(_ sender: Any) {

    }
}
