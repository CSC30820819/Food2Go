//
//  ViewController.swift
//  Food2Go
//
//  Created by Makendra Phipps on 3/17/26.
//

import UIKit

class ViewController: UIViewController {

    var categoryToSend: String = ""
    var colorToSend: UIColor?
    
    @IBAction func categoryTapped(_ sender: UIButton) {
        let title = sender.configuration?.title ?? sender.currentTitle ?? ""
            
        categoryToSend = title
        colorToSend = sender.configuration?.baseBackgroundColor ?? sender.backgroundColor
        
        
        print("Button Pressed! Title found: \(categoryToSend)")
            
        if !categoryToSend.isEmpty {
            performSegue(withIdentifier: "goToCategory", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCategory" {
            if let navVC = segue.destination as? UINavigationController, let destinationVC = navVC.viewControllers.first as? CategoryViewController {
                    
                destinationVC.receivedCategory = categoryToSend
                destinationVC.receivedColor = colorToSend
            } else if let destinationVC = segue.destination as? CategoryViewController {
                    destinationVC.receivedCategory = categoryToSend
                    destinationVC.receivedColor = colorToSend
            }
        }
    }
    
    @IBAction func viewCartTapped(_ sender: UIButton) {
        print("goToCart")
        performSegue(withIdentifier: "goToCart", sender: self)
    }
}

