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
                          headers: headers).responseJSON { response in
            debugPrint(response)
        }
        
        super.viewDidLoad();
    }
    
}
