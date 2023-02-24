//
//  MoreCell.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 15.11.2022.
//

import Foundation
import UIKit

class MoreCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    private let symbol: UIImageView = {
       let imageView = UIImageView()
//        let image = UIImage(systemName: "sunrise")
//        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let separetor: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        //label.text = "Время восхода солнца"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        //label.text = "6:00"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addNewElement()
        addConstraintsOnView()
            backgroundColor = #colorLiteral(red: 0.8398272395, green: 0.9403695464, blue: 0.9815813899, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func addNewElement() {
        contentView.addSubview(symbol)
        contentView.addSubview(separetor)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(valueLabel)
    }
    
    
    private func addConstraintsOnView() {
        NSLayoutConstraint.activate([
            symbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            symbol.widthAnchor.constraint(equalToConstant: 50),
            
            separetor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            separetor.leadingAnchor.constraint(equalTo: symbol.trailingAnchor),
            separetor.widthAnchor.constraint(equalToConstant: 0.4),
            separetor.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: separetor.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: 160),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
        ])
    }
    
    func setup(model: [MoreCellModel.Row]?) {
        descriptionLabel.text = model?.first?.titl
        valueLabel.text = model?.first?.valueTitle
        symbol.image = model?.first?.icon
}
    
}
