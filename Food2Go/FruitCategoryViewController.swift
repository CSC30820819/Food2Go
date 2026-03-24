//
//  FruitCategoryViewController.swift
//  Food2Go
//
//  Created by Makendra Phipps on 3/21/26.
//

import UIKit

class FruitCategoryViewController: UIViewController {

    
    var updateCart: [(name: String, quantity: Int, price: Double)] = []
    
    var newItem:(name: String, quantity: Int, price: Double)?
    
    @IBAction func backToHome(_ sender: Any) {
        
        //Add code to transfer cart data
        self.dismiss(animated: true)
        
    }
    
    //Prepare function to update the product view and cart in the home page
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
