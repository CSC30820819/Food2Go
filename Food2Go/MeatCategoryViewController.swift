//
//  MeatCategoryViewController.swift
//  Food2Go
//
//  Created by Makendra Phipps on 3/21/26.
//

import UIKit

class CategoryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var itemNameLabels: [UILabel]!
    @IBOutlet var priceLabels: [UILabel]!
    @IBOutlet var quantityTextFields: [UITextField]!
    @IBOutlet var steppers: [UIStepper]!
    
    
    var receivedCategory: String?
    var receivedColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bgColor = receivedColor {
            self.view.backgroundColor = bgColor
        }
        
        for textField in quantityTextFields {
            textField.delegate = self
        }
        
        self.navigationItem.title = ""
        self.navigationItem.largeTitleDisplayMode = .never
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        if let category = receivedCategory {
            titleLabel.text = category
            populateUI(for: category)
        }
    }
    
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        let index = sender.tag
        let newValue = Int(sender.value)
        
        quantityTextFields[index].text = "\(newValue)"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = textField.tag
        
        if let text = textField.text, let customValue = Double(text) {
            let clampedValue = max(0, min(20, customValue))
            
            
            steppers[index].value = clampedValue
            textField.text = "\(Int(clampedValue))"
        } else {
            
            textField.text = "0"
            steppers[index].value = 0
        }
    }
    func populateUI(for category: String) {
        guard let items = groceryData[category] else { return }
        
        for i in 0..<itemNameLabels.count {
            if i < items.count {
                let currentItem = items[i]
                itemNameLabels[i].text = currentItem.name
                priceLabels[i].text = String(format: "$%.2f", currentItem.price)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
