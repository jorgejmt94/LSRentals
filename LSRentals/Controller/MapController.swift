//
//  MapController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var switchButton: UISwitch!

    @IBOutlet weak var mapView: MKMapView!;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: peticio apartaments
        let singleton = Singleton.getInstance();
        
        for point in singleton.getMapPoints() {
            
            mapView.addAnnotation(point);
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "sharedIdentifier");
        
        annotationView.canShowCallout = true;
        annotationView.pinTintColor = MKPinAnnotationView.redPinColor();
        
        return annotationView;
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {

        UserConfig.deleteUser();
        self.navigationController?.popViewController(animated: true);

    }
}
