//
//  HttpRequest.swift
//  LSRentals
//
//  Created by Albert Pernía Vázquez on 25/12/2017.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation

public class HttpRequest {
    
    /*
     * Sends an asynchronous HTTP request.
     *
     * @param url: The full Web Service URL, including the function/endpoint.
     * @param requestType: The HTTP request type: POST, GET, HEAD...
     * @param handler: any instance of a class that implements the RequestProtocol
     */
    public func send(url: String!, requestType: String, handler: RequestProtocol) throws {
        
        let jsonData = try JSONSerialization.data(withJSONObject: handler.getParameters());
        let link = URL(string: url)!;
        
        var request = URLRequest(url: link);
        request.httpMethod  = requestType;
        request.httpBody    = jsonData;
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any];

                handler.onResponse(responseData: json!);
                
            } catch {
                handler.onError(msg: "Deserialization error.");
            }
        }).resume();
    }
    
}
