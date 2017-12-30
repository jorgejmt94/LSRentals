//
//  ApartmentDetailsController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ApartmentDetailsController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var apartmentNameLabel: UILabel!
    @IBOutlet weak var apartmentAddressLabel: UILabel!
    @IBOutlet weak var apartmentCapacityLabel: UILabel!
    @IBOutlet weak var apartmentDescriptionLabel: UILabel!
    @IBOutlet weak var rentButton: UIButton!
    
    private let singleton = Singleton.getInstance();
    public var apartmentIdSegue: Int!;

    @IBOutlet weak var mapView: MKMapView!

    var images: [UIImage]!;
    @IBOutlet weak var imageCarousel: ImageCarouselView!
    
    
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad();
        self.mapView.isZoomEnabled = false;
        self.mapView.isScrollEnabled = false;
        self.mapView.isUserInteractionEnabled = false;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        //fill info to labels
        self.tabBarController?.tabBar.isHidden = true;
        let apartment = singleton.getApartment(key: self.apartmentIdSegue);
        self.apartmentNameLabel.text = apartment!.name;
        self.apartmentAddressLabel.text = apartment!.location.address;
        self.apartmentCapacityLabel.text = String(apartment!.maxCapacity);
        self.apartmentDescriptionLabel.text = String(apartment!.info);
        if !apartment!.available {
            rentButton.removeFromSuperview();
        }
        
        
        let mainImageUrl:URL = URL(string: apartment!.images.main)!;

        let mainImageData:NSData = NSData(contentsOf: mainImageUrl)!
        let mainImage = UIImage(data: mainImageData as Data)
        images = [ mainImage!];
        
        
        for i in 0..<apartment!.images.others.count {
            let imageUrl:URL = URL(string: apartment!.images.others[i])!;
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            let image = UIImage(data: imageData as Data)
            images.append(image!);
        }
        
        imageCarousel.images = images

        //print map
        for point in singleton.getMapPoints() {
            if point.id == self.apartmentIdSegue {
                point.subtitle = nil;
                point.title = nil;
                mapView.addAnnotation(point);
            }
        }
        let initialLocation = CLLocation(latitude: apartment!.location.latitude, longitude: apartment!.location.longitude);
        // center the map to barcelona
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                  1000, 1000);
        mapView.setRegion(coordinateRegion, animated: true);
        
        
    }

    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "sharedIdentifier");
        
        annotationView.canShowCallout = true;
        annotationView.pinTintColor = MKPinAnnotationView.redPinColor();
        
        return annotationView;
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Rent" {
            
            let nextView = segue.destination as? RentController;
            nextView?.aparmentId = apartmentIdSegue;
        }
    }
    
    @IBAction func rentButton(_ sender: Any) {
        self.performSegue(withIdentifier: "Rent", sender: self);
    }

    
    
    
}
