//
//  CartViewController.swift
//  Food2Go
//
//  Created by Makendra Phipps on 3/21/26.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Home"
        navigationItem.backBarButtonItem = backButton
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        updateCheckoutButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCheckout" {
            guard Cart.items.count > 0 else {
                return
            }
            let destiationVC = segue.destination as! OrderSuccessViewController
            destiationVC.totalAmount = calculateTotal()
        }
    }
    
    //clear cart when leaving view
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Cart.items.removeAll()
        tableView.reloadData()
        updateCheckoutButton()
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        
        let productH = UILabel()
        let priceH = UILabel()
        let qtyH = UILabel()
        let totalH = UILabel()
        let spacerH = UIView()
        
        productH.text = "PRODUCT"
        priceH.text = "PRICE"
        qtyH.text = "QTY"
        totalH.text = "TOTAL"
        
        [productH, priceH, qtyH, totalH].forEach {
            $0.font = .systemFont(ofSize: 10, weight: .bold)
            $0.textColor = .secondaryLabel
        }
        
        let stack = UIStackView(arrangedSubviews: [productH, priceH, qtyH, totalH, spacerH])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        priceH.widthAnchor.constraint(equalToConstant: 50).isActive = true
        qtyH.widthAnchor.constraint(equalToConstant: 30).isActive = true
        totalH.widthAnchor.constraint(equalToConstant: 60).isActive = true
        spacerH.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        headerView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: headerView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //footer (total price)
        if indexPath.row == Cart.items.count {
            let cell = UITableViewCell()
            //calculate total
            let total = calculateTotal()
            cell.textLabel?.text = "Total (+ tax): \(String(format: "$%.2f", total))"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            cell.textLabel?.textAlignment = .right
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
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func calculateTotal() -> Double {
        var total: Double = 0
        for item in Cart.items {
            total += item.item.price * Double(item.quantity)
        }
        //total with tax
        return total + (total * 0.06)
    }
    
    //remove ONE qty of an item inside cart
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
        updateCheckoutButton()
    }
    
    func updateCheckoutButton() {
        if Cart.items.isEmpty {
            checkoutButton.isEnabled = false
        }else {
            checkoutButton.isEnabled = true
        }
    }
    
    //checkout button
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Checkout", message: "Are you sure you want to checkout?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.performSegue(withIdentifier: "goToCheckout", sender: self)
            Cart.items.removeAll()
            self.tableView.reloadData()
            self.updateCheckoutButton()
            print("checked out")
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (_) in
            print("cancelled checkout")
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
}
