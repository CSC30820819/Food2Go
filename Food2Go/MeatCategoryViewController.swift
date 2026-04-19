//
//  MeatCategoryViewController.swift
//  Food2Go
//
//  Created by Makendra Phipps on 3/21/26.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToCart: UIButton!
    
    var receivedCategory: String?
    var receivedColor: UIColor?
    var itemsToShow: [GroceryItem] = []
    var currentSelections: [String: Int] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoryItemCell.self, forCellReuseIdentifier: "CategoryItemCell")
        
        if let bgColor = receivedColor {
            self.view.backgroundColor = bgColor
        }
        
        if let category = receivedCategory {
            titleLabel.text = category
            itemsToShow = groceryData[category] ?? []
        }
        
        updateAddToCartButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.clear]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        self.navigationItem.title = ""
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        
        let nameH = UILabel()
        let priceH = UILabel()
        let qtyH = UILabel()
        let spacerH = UIView()
        
        nameH.text = "ITEM"
        priceH.text = "PRICE"
        qtyH.text = "QTY"
        
        [nameH, priceH, qtyH].forEach {
            $0.font = .systemFont(ofSize: 12, weight: .bold)
            $0.textColor = .secondaryLabel
        }
        
        let stack = UIStackView(arrangedSubviews: [nameH, priceH, qtyH, spacerH])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        priceH.widthAnchor.constraint(equalToConstant: 60).isActive = true
        qtyH.widthAnchor.constraint(equalToConstant: 40).isActive = true
        spacerH.widthAnchor.constraint(equalToConstant: 94).isActive = true
        
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
        return 40
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryItemCell", for: indexPath) as! CategoryItemCell
        
        let item = itemsToShow[indexPath.row]
        cell.nameLabel.text = item.name
        cell.priceLabel.text = String(format: "$%.2f", item.price)
        
        let qty = currentSelections[item.name] ?? 0
        cell.quantityTextField.text = "\(qty)"
        cell.stepper.value = Double(qty)
        
        cell.quantityChanged = { [weak self] newQty in
            self?.currentSelections[item.name] = newQty
            self?.updateAddToCartButton()
        }
        
        cell.selectionStyle = .none
        return cell
    }

    func updateAddToCartButton() {
        let total = currentSelections.values.reduce(0, +)
        addToCart.isEnabled = total > 0
    }

    @IBAction func addToCartPressed(_ sender: UIButton) {
        for (itemName, quantity) in currentSelections where quantity > 0 {
            guard let item = itemsToShow.first(where: { $0.name == itemName }) else { continue }
            
            if let index = Cart.items.firstIndex(where: { $0.item.name == item.name }) {
                Cart.items[index].quantity += quantity
            } else {
                Cart.items.append(CartItem(item: item, quantity: quantity))
            }
        }
        
        print("Cart Items:")
        for item in Cart.items {
            print("\(item.item.name) - Qty: \(item.quantity)")
        }
        
        let alert = UIAlertController(title: "Added to Cart!", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.currentSelections.removeAll()
            self.tableView.reloadData()
            self.updateAddToCartButton()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
