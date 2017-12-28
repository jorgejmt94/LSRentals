//
//  RentController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RentController: UIViewController {
    
    @IBOutlet weak var apartmentNameLabel: UILabel!
    @IBOutlet weak var apartmentAddressLabel: UILabel!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var dateIn: UIDatePicker!
    @IBOutlet weak var dateOut: UIDatePicker!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var numberOfPeople: UITextField!
    
    var aparmentId: Int!;
    private let singleton = Singleton.getInstance();
    
    
    @IBAction func stepperChanged(_ sender: Any) {
        numberOfPeople.text = Int(stepper.value).description;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let apartment = singleton.getApartment(key: self.aparmentId);
        self.apartmentNameLabel.text = apartment!.name;
        self.apartmentAddressLabel.text = apartment!.location.address;
        
        stepper.autorepeat = true;
        stepper.minimumValue = 0;
        numberOfPeople.isUserInteractionEnabled = false;
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func rentButton(_ sender: Any) {
        //TODO: enviar reserva
        
        print("on rent button");
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "YYYY-MM-dd";
        var userName: String;
        userName = self.name.text! + " " + self.surname.text!;
        
        let parameters: Parameters = [
        
            "apartment": aparmentId,
            "customer": [
                //"name": UserConfig.getRememberUserName(),
                "name": userName,
                "start_date": dateFormatter.string(from: dateIn!.date),
                "end_date": dateFormatter.string(from: dateOut!.date),
                "number_of_people": Int(stepper.value)
            ]
        ];
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(WSRentals.getToken()!)",
        ]
        
        Alamofire.request(WSRentals.getWebServiceURL(function: WSRentals.FUNC_BOOK),
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers).validate(statusCode: 200..<300)
            .responseJSON { response in

                self.onRequestResponse(response: response)
        }
    }
    
    private func onRequestResponse(response: DataResponse<Any>) {
        
        let alertAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.default) { UIAlertAction in
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        if (response.result.error == nil) {
            
            let json = response.result.value as! NSDictionary;
            let succeed: Bool = json.value(forKey: "succeed") as? Int == 1;
            if succeed {
                
                self.showDefaultAlertDialog(
                    title: "Apartment rent!",
                    msg: "The book could be done.",
                    action: alertAction
                );
            }
            else {
                self.showDefaultAlertDialog(
                    title: "Not available",
                    msg: "The book could not be done for the specified dates.",
                    buttonTitle: "Accept"
                );
            }
        }
        else {  // failed
            self.showDefaultAlertDialog(
                title: "Network error",
                msg: "An error happened obtaining the apartments info",
                action: alertAction
            );
        }
    }
    
}
