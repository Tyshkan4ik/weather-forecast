//
//  FavoritesCell.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 15.11.2022.
//

import Foundation
import UIKit

class FavoritesCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    var coordinatesLat: Double?
    var coordinatesLon: Double?
    
    let backgroundViewCell: GradientView3 = {
        var view = GradientView3(colors: [UIColor(red:105/255, green:225/255, blue:213/255, alpha:1).cgColor, UIColor(red:0/255, green:173/255, blue:255/255, alpha:1).cgColor])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let cityLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 20)
        label.adjustsFontSizeToFitWidth = true
        //label.text = "Санкт-Петербург"
        label.alpha = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let degrees: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .AAvanteBsExtraBold(size: UIScreen.main.bounds.width / 12)
        label.adjustsFontSizeToFitWidth = true
        //label.text = "27°"
        label.alpha = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 40)
        label.adjustsFontSizeToFitWidth = true
        //label.text = "Облачно с прояснениями"
        label.alpha = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addNewElement()
        addConstraintOnView()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func addNewElement() {
        contentView.addSubview(backgroundViewCell)
        backgroundViewCell.addSubview(cityLabel)
        backgroundViewCell.addSubview(degrees)
        backgroundViewCell.addSubview(infoLabel)
    }
    
    private func addConstraintOnView() {
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backgroundViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backgroundViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            backgroundViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 20),
            cityLabel.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor),
            
            degrees.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor),
            degrees.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20),
            degrees.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: degrees.bottomAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: degrees.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: backgroundViewCell.bottomAnchor, constant: -10)
        ])
    }
    
    func setup(model: FavoritesCellModel?) {
        cityLabel.text = model?.cityName
        degrees.text = String(format: "%0.1f", model?.temperature ?? 0) + "°"
        infoLabel.text = model?.description
    }
}
