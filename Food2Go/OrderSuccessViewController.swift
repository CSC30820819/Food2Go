//
//  OrderSuccessViewController.swift
//  Food2Go
//
//  Created by Makendra Phipps on 3/21/26.
//

import UIKit

class OrderSuccessViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    var totalAmount: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var viewControllers = navigationController?.viewControllers {
            viewControllers.removeAll { $0 is CartViewController }
            navigationController?.viewControllers = viewControllers
        }
        totalLabel.text = "Your total was: \(String(format: "$%.2f", totalAmount))"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
