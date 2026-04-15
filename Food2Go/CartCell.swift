//
//  CartCell.swift
//  Food2Go
//
//  Created by Mesplay, Harrison W. on 4/12/26.
//

import UIKit

//new cell for cart table view (4 Labels instead of 1)
class CartCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
}
