//
//  WSConstants.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 25/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation


struct WSRentals {
    
    static let BASE_URL = "https://v2msoft.com/clientes/lasalle/ios-17-18/";
    
    static let FUNC_LOGIN   = "login.php";
    
    static func getWebServiceURL(function: String) -> String {
        
        return BASE_URL + function;
    }
}
