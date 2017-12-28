//
//  WSConstants.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 25/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation


struct WSRentals {
    
    static var token: String? = nil;
    
    static let BASE_URL                     = "https://v2msoft.com/clientes/lasalle/ios-17-18/";
    
    static let FUNC_LOGIN                   = "login.php";
    
    static let FUNC_REMEMBER_PASSWORD       = "remember_password.php";
    
    static let FUNC_APARTMENTS              = "apartments.php";
    
    static let FUNC_BOOK                    = "book.php";
    
    static func getWebServiceURL(function: String) -> String {
        
        return BASE_URL + function;
    }
    
    static func setToken(tkn: String) {
        
        token = tkn;
    }
    
    static func getToken() -> String? {
        
        return token;
    }
}
