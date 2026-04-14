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
    
    
    @IBOutlet weak var addToCart: UIButton!
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
        
        addToCartEnable()
    }
    
    
    func addToCartEnable(){
        var enable = false
        for i in quantityTextFields{
            if let amount = Int(i.text ?? "0"), amount > 0{
                enable = true
                break
            }
        }
        
        addToCart.isEnabled = enable
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
    
    //add to cart func
    @IBAction func addToCartPressed(_ sender: UIButton) {
        guard let category = receivedCategory,
        let items = groceryData[category] else { return }
        //for each textField in category (9)
        for textField in quantityTextFields {
            //get current tag and quantity
            let index = textField.tag
            let quantity = Int(textField.text ?? "0") ?? 0
            //if user selected this item (quantity > 0) otherwise move to next item
            if quantity <= 0 { continue }
            //get name of item
            let name = itemNameLabels.first(where: { $0.tag == index})?.text ?? ""
            //find correct item
            guard let groceryItem = items.first(where: { $0.name == name}) else { continue }
            //if current item currently exists in cart add to quantity
            if let existingIndex = Cart.items.firstIndex(where: { $0.item.name == groceryItem.name }) {
                Cart.items[existingIndex].quantity += quantity
            //otherwise add item to cart
            }else {
                Cart.items.append(CartItem(item: groceryItem, quantity: quantity))
            }
        }
        //debug
        print("Cart Items:")
        for item in Cart.items {
            print("\(item.item.name) - Qty: \(item.quantity)")
        }
        for i in 0..<items.count {
            print("Index \(i): \(items[i].name)")
        }
    }
}

