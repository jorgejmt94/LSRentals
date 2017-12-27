//
//  ApartmentTabBarController.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 26/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import UIKit
import Alamofire

public class ApartmentTabBarController : UITabBarController {
    
    override public func viewDidLoad() {
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(WSRentals.getToken()!)",
        ]

        Alamofire.request(WSRentals.getWebServiceURL(function: WSRentals.FUNC_APARTMENTS),
                            headers: headers)
            .responseJSON {
                response in
                    
                if let status = response.response?.statusCode {
                    
                    switch (status) {
                        
                        case 200:
                            
                            if let result = response.result.value {
                                
                                self.parseApartments(data: result as! NSDictionary)
                            }
                            else {
                                self.showDefaultAlertDialog(title: "Network error", msg: "An error happened obtaining the apartments info", buttonTitle: "Back");
                                // TODO: pop view
                            }
                            break;
                        
                        default:
                            self.showDefaultAlertDialog(title: "Network error", msg: "An error happened obtaining the apartments info", buttonTitle: "Back");
                        // TODO: pop view
                        
                    }
                }
        }
        .responseData { response in
                
                debugPrint(response)
            

        }
        
        super.viewDidLoad();
    }
    
    
    private func parseApartments(data: NSDictionary) {
        
        //print(data);
    }
}
