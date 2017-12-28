//
//  RememberPasswordController.swift
//  LSRentals
//
//  Created by Jorge Melguizo Torres on 28/12/17.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit
class RememberPasswordController: UIViewController, RequestProtocol {
    @IBOutlet weak var mailText: UITextField!
    
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "PasswordRemembered", sender: self);
    }
    
    
    @IBAction func rememberButton(_ sender: Any) {
        
        // TODO: validate parameters
        let request = HttpRequest();
        
        do {
            try request.send(
                url: WSRentals.getWebServiceURL(function: WSRentals.FUNC_REMEMBER_PASSWORD),
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
            "mail": mailText.text!
        ];
        
        return params;
    }
    
    func onResponse(responseData: [String: Any]) {
        
        let success = responseData["succeed"] as? Int;
        
        if success == 1 {   // request was OK
            
            //TODO: NO VA y  enviar mail y ponerlo en el textfield
            self.performSegue(withIdentifier: "PasswordRemembered", sender: self);
        }
        else {  // an error happened with the data provided by the user
            DispatchQueue.main.async {
                self.showDefaultAlertDialog(title: "Authentication error", msg: "The email is incorrect. Please, try again.", buttonTitle: "Accept");
            }
        }
    }
    
    func onError(msg: String) {
        
        print(msg);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "PasswordRemembered"){
            
            let rememberedPassword = segue.destination as? LoginController;
            rememberedPassword!.valueToSendOnSegue = mailText.text;
        }
    }
    
    
}
