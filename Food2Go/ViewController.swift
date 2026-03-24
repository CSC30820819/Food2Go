//
//  ViewController.swift
//  Food2Go
//
//  Created by Makendra Phipps on 3/17/26.
//

import UIKit

class ViewController: UIViewController {

    
   //Include a prepare function to pass the cart variable to update it (Product View) or to view it (Cart View)
    var cart: [(name: String, quantity: Int, price: Double)] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? FruitCategoryViewController{
            dest.updateCart = cart
        }
        if let dest = segue.destination as? VegetableCategoryViewController{
            dest.updateCart = cart
        }
        if let dest = segue.destination as? GrainCategoryViewController{
            dest.updateCart = cart
        }
        if let dest = segue.destination as? MeatCategoryViewController{
            dest.updateCart = cart
        }
        if let dest = segue.destination as? DairyCategoryViewController{
            dest.updateCart = cart
        }
        if let dest = segue.destination as? DrinkCategoryViewController{
            dest.updateCart = cart
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //update cart
    }


}

