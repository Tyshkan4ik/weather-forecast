//
//  ElementViewForInfoCell.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 04.11.2022.
//

import Foundation
import UIKit


class Element: UIView {
    
    let image: UIImageView = {
       let imageView = UIImageView()
        //imageView.tintColor =
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titl: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .center
        
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueTitl: UILabel = {
    let label = UILabel()
        label.numberOfLines = 0
     label.textColor = .black
        label.textAlignment = .center
     label.translatesAutoresizingMaskIntoConstraints = false
     return label
 }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElementForView()
        addConstraintForView()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func addElementForView() {
        addSubview(image)
        addSubview(titl)
        addSubview(valueTitl)
    }
    
    private func addConstraintForView() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            image.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            titl.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            titl.leadingAnchor.constraint(equalTo: leadingAnchor),
            titl.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valueTitl.topAnchor.constraint(equalTo: titl.bottomAnchor),
            valueTitl.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueTitl.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueTitl.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueTitl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        image.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func setup(model: InfoCellModel.ElementModel?) {
        image.image = model?.image
        titl.text = model?.title.firstUppercased
        valueTitl.text = model?.description.firstUppercased
    }
    
    
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
