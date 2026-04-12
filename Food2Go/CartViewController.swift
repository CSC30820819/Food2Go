//
//  CartViewController.swift
//  Food2Go
//
//  Created by Makendra Phipps on 3/21/26.
//

import UIKit

class CartViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        //display cell
        return cell
    }
}
