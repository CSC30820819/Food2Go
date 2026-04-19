//
//  CategoryItemCell.swift
//  Food2Go
//
//  Created by Kramer, Jenna L. on 4/19/26.
//

import UIKit

class CategoryItemCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let quantityTextField = UITextField()
    let stepper = UIStepper()
    
    var quantityChanged: ((Int) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.numberOfLines = 1
        
        priceLabel.font = .systemFont(ofSize: 14)
        priceLabel.textColor = .darkGray
        priceLabel.textAlignment = .right
        
        priceLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        quantityTextField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        quantityTextField.textAlignment = .center
        quantityTextField.borderStyle = .roundedRect
        quantityTextField.isUserInteractionEnabled = false
        
        stepper.addTarget(self, action: #selector(stepperTapped), for: .valueChanged)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel, quantityTextField, stepper])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }

    @objc func stepperTapped() {
        let val = Int(stepper.value)
        quantityTextField.text = "\(val)"
        quantityChanged?(val)
    }
}
