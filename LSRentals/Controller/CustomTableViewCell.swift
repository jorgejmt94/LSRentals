//
//  CustomTableViewCell.swift
//  LSRentals
//
//  Created by Jorge Melguizo Torres on 29/12/17.
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell{
    
 
    @IBOutlet weak var apartmentImage: UIImageView!
    @IBOutlet weak var apartmentName: UILabel!
    @IBOutlet weak var apartmentAddress: UILabel!
    @IBOutlet weak var apartmentCapacity: UILabel!
    @IBOutlet weak var apartmentDays: UILabel!
    @IBOutlet weak var progressImgLoad: UIActivityIndicatorView!;
    
    
    public func setInfo(name: String, address: String, image: String, maxDays: Int, maxCapacity: Int){
        self.apartmentName.text = name;
        self.apartmentAddress.text = address;
        self.apartmentCapacity.text = String(maxCapacity);
        self.apartmentDays.text = String(maxDays);
        self.progressImgLoad.startAnimating();
        
        let imageUrl:URL = URL(string: image)!;
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            //imageView.center = self.apartmentImage.center
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                self.progressImgLoad.stopAnimating();
                self.progressImgLoad.isHidden = true;
                let imageView = UIImageView(frame: CGRect(x:0, y:0, width:100, height:90))
                let image = UIImage(data: imageData as Data)
                imageView.image = image
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                self.apartmentImage.addSubview(imageView)
            }
        }
        
    }
}
