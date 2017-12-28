//
//  TableController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation


import UIKit
import MapKit
import Alamofire

class TableController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var capacity: UITextField!
    
    
    private var keys = [Int]();         // all keys
    private var currentKeys = [Int]();  // filtered keys
    
    private let singleton = Singleton.getInstance();
    private var idSegue = 0;
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        UserConfig.deleteUser();
        self.navigationController?.popViewController(animated: true);
        //  TODO no va del tot be
    }
    
    @IBAction func stepperChanged(_ sender: Any) {
        capacity.text = Int(stepper.value).description;
        
        filter();
        tableView.reloadData();
    }
    
    @IBAction func switchButtonChanged(_ sender: Any) {
        
        filter();
        tableView.reloadData();
    }
    
    private func filter() {
        
        currentKeys.removeAll();
        
        if !switchButton.isOn {
            
            self.currentKeys = keys;
            return;
        }
        
        for key in keys {
            
            let apartment = singleton.getApartment(key: key);
            
            if (apartment?.maxCapacity)! >= Int(capacity.text!)! && apartment?.available == true {
                
                currentKeys.append((apartment?.identifier)!);
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
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
        
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Apartments";
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentKeys.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellIdentifier");
        
        let apartment = singleton.getApartment(key: currentKeys[indexPath.row]);
     
        cell.textLabel!.text = "name: \(apartment!.name)";

        return cell;
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "ApartamentDetails"){
            
            let apartmentDetails = segue.destination as? ApartmentDetailsController;
            apartmentDetails!.apartmentIdSegue = self.idSegue;
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected: \(indexPath.row)");
        
        let apartment = singleton.getApartment(key: currentKeys[indexPath.row]);
        self.idSegue = apartment!.identifier;
        //TODO: peticio dels detalls de l'apartament per enviar a la seguent
        self.performSegue(withIdentifier: "ApartamentDetails", sender: self);        
    }
    
    
    // horrible
    private func parseApartments(data: NSDictionary) {
        var apartments  = [Int: Apartment]();
        var mapPoints   = [MapAnnotation]();
        
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
            let point = MapAnnotation(coordinate: CLLocationCoordinate2DMake(location.latitude, location.longitude), title: current.name, info: current.info, id: current.identifier);
            mapPoints.append(point);
        }
        
        let singleton = Singleton.getInstance();
        singleton.setApartments(apartments);
        singleton.setMapPoints(mapPoints);
        self.keys = Array(apartments.keys);
        self.currentKeys = Array(apartments.keys);
        tableView.reloadData();
        print("count on tab: \(apartments.count)");
    }
}
