//
//  RequestListener.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 25/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation

/*
 * A standarization of how all the Web Service HTTP request will be
 * handled in the application created.
 */
public protocol RequestProtocol {
    
    /*
     * When implemented, the method returns all the Http request parameters
     * needed for a specific function of the Web Service.
     *
     * @return The http request parameters as <key,value> pairs.
     */
    func getParameters() -> ([String: Any]);
    
    /*
    * This method is expected to be called when a http request finnishes
    * and some kind of data is returned as response. Then, this is the
    * "root" method from where parse the response data needed for any
    * user action.
    *
    * @param responseData: json data in an accessible <key,value> pairs format.
    */
    func onResponse(responseData: [String: Any]);
    
    /*
    * Can be used to print a msg to the user in, for example, an UIAlert. But
    * it does not seems very useful almost right now.
    */
    func onError(msg: String);
    
    

}
