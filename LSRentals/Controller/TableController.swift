//
//  TableController.swift
//  LSRentals
//
//  Copyright © 2017 Albert i Jorge. All rights reserved.
//

import Foundation


import UIKit

class TableController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    var  apartments = Array<String>();
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: rellenar array
        apartments.append("uno");
        apartments.append("dos");
        apartments.append("tres");
    }

    @IBAction func logOutButton(_ sender: Any) {
        //TODO: esborrar credencials
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return apartments.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellIdentifier");
        
        
        cell.textLabel!.text = apartments[indexPath.row];
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected: \(indexPath.row)");
        print(apartments[indexPath.row])
        //TODO: peticio dels detalls de l'apartament per enviar a la seguent
        self.performSegue(withIdentifier: "ApartamentDetailsController", sender: self);

        
        tableView.reloadData();
        
    }
    
    
}
