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
                          method: .post, headers: headers).validate(statusCode: 200..<300)
            .responseJSON {
                response in
                
                if (response.result.error == nil) {

                    let json = response.result.value as! NSDictionary;
                    self.parseApartments(data: json);
                }
                else {  // failed
                    self.showDefaultAlertDialog(
                        title: "Network error",
                        msg: "An error happened obtaining the apartments info",
                        buttonTitle: "Back"
                    );
                }
        }
        
        super.viewDidLoad();
    }
    
    // horrible
    private func parseApartments(data: NSDictionary) {
        var apartments = [Int: Apartment]();

        let jsonApartments = data.value(forKeyPath: "apartments") as! NSArray;

        for apartment in jsonApartments {
            
            let ap = apartment as! NSDictionary;
            let jsLoc = ap["location"] as! NSDictionary;
            let location = Location(address: jsLoc["address"] as! String,
                                    latitude: jsLoc["latitud"] as! Double,
                                    longitude: jsLoc["longitud"] as! Double
            );
            
            let jsImages = ap["images"] as! NSDictionary;
            let mainImage = jsImages["main"] as! String;
            let jsOthers = jsImages.value(forKey: "other") as! NSArray;
            var others = [String]();
            
            for img in jsOthers {
                
                others.append(img as! String);
            }
            let images = Images(main: mainImage, others: others);

            let current = Apartment(
                identifier: ap["identifier"] as! Int,
                name: ap["name"] as! String,
                info: ap["information"] as! String,
                location: location,
                images: images,
                available: ap["available"] as! Bool,
                maxCapacity: ap["maximum_capacity"] as! Int,
                maxDays: ap["maximum_days"] as! Int
            );
            
            apartments[current.identifier] = current;
        }
        
        Singleton.getInstance().setApartments(apartments);
    }
}
