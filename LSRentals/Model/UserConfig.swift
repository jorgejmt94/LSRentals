//
//  UserConfig.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 26/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation

struct UserConfig {
    
    static public let USERNAME    = "username";
    static public let TOKEN       = "token";
    
    static func rememberUser(login: String, token: String) {
        
        UserDefaults.standard.set(login, forKey: USERNAME);
        UserDefaults.standard.set(token, forKey: TOKEN);
    }
    
    static func deleteUser(){
        UserDefaults.standard.removeObject(forKey: TOKEN);
    }
    
    static func getRememberedUserData() -> ([String: String])? {
        
        let user    = UserDefaults.standard.string(forKey: USERNAME);
        let tkn     = UserDefaults.standard.string(forKey: TOKEN);
        
        if (user == nil || tkn == nil) {
            return nil;
        }
        
        let config : [String: String] = [
            
            USERNAME:   user!,
            TOKEN:      tkn!
        ];
        
        return config;
    }
    
    static func getRememberUserName() -> String{
        return  UserDefaults.standard.string(forKey: USERNAME)!;
    }
}
