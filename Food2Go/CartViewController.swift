//
//  CartViewController.swift
//  Food2Go
//
//  Created by Makendra Phipps on 3/21/26.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        //debug
        print("Cart count: \(Cart.items.count)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.items.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //debug
        print("cellForRowAt: \(indexPath.row)")
        //footer (total price)
        if indexPath.row == Cart.items.count {
            let cell = UITableViewCell()
            //calculate total
            var total: Double = 0
            for item in Cart.items {
                total += item.item.price * Double(item.quantity)
            }
            cell.textLabel?.text = "Total: \(String(format: "$%.2f", total))"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            return cell
        }
        //main table (cart)
        else {
            //make cell with custom cart cell class
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
            //select cart item
            let cartItem = Cart.items[indexPath.row]
            //change cell values to match cart item
            cell.nameLabel.text = cartItem.item.name
            cell.priceLabel.text = String(format: "$%.2f", cartItem.item.price)
            cell.quantityLabel.text = "\(cartItem.quantity)"
            let total = cartItem.item.price * Double(cartItem.quantity)
            cell.totalPriceLabel.text = String(format: "$%.2f", total)
            //tag for each button in each row
            cell.minusButton.tag = indexPath.row
            return cell
        }
    }
    
    @IBAction func minusOne(_ sender: UIButton) {
        let index = sender.tag
        //if more than one item just remove one from quantity
        if Cart.items[index].quantity > 1 {
            Cart.items[index].quantity -= 1
        //otherwise remove item from cart entirely
        }else {
            Cart.items.remove(at: index)
        }
        tableView.reloadData()
    }
    
}
