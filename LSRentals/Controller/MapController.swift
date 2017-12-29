//
//  MapController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!;

    private var pointId: Int?;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);

        mapView.delegate = self;
        //TODO: peticio apartaments
        let singleton = Singleton.getInstance();
        
        for point in singleton.getMapPoints() {
            
            mapView.addAnnotation(point);
        }
        
        let initialLocation = CLLocation(latitude: 41.373131, longitude: 2.1401831);
        // center the map to barcelona
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                  50000, 50000);
        mapView.setRegion(coordinateRegion, animated: true);
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "sharedIdentifier");
        
        annotationView.canShowCallout = true;
        annotationView.pinTintColor = MKPinAnnotationView.redPinColor();
        
        return annotationView;
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let point = view.annotation as? MapAnnotation;
        pointId = point?.id;
        self.performSegue(withIdentifier: "ApartamentDetails", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextView = segue.destination as? ApartmentDetailsController;
        nextView?.apartmentIdSegue = pointId;
    }
    
    @IBAction func logOutButton(_ sender: Any) {

        UserConfig.deleteUser();
        //  TODO no va del tot be
        self.navigationController?.popViewController(animated: true);

    }
}
