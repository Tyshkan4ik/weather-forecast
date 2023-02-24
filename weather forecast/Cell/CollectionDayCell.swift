//
//  CollectionDayCell.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 13.11.2022.
//

import Foundation
import UIKit

class CollectionDayCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) {
                self.backgroundView = GradientView2(colors: [UIColor(red:105/255, green:225/255, blue:213/255, alpha:1).cgColor, UIColor(red:0/255, green:173/255, blue:255/255, alpha:1).cgColor])
                }
            }
            else {
                UIView.animate(withDuration: 0.3) { // for animation effect
                     self.backgroundView = UIView()
                }
            }
        }
    }
    
    let image: UIImageView = {
       let imageView = UIImageView()
        //let image = UIImage(systemName: "cloud.sun.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width/10, weight: .bold))
        let image = UIImage(named: "облачно с прояснениями")
        imageView.image = image
        //imageView.contentMode = .scaleAspectFill
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var dayWeek: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        //lable.numberOfLines = 1
        //lable.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width / 20)
        lable.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 20)
        lable.adjustsFontSizeToFitWidth = true
        lable.text = "ПН"
        lable.alpha = 0.7
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var date: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        //lable.numberOfLines = 1
        //lable.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width / 20)
        lable.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 25)
        lable.adjustsFontSizeToFitWidth = true
        lable.text = "02/11"
        lable.alpha = 0.5
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let degrees: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        //lable.text = "27°"
        lable.adjustsFontSizeToFitWidth = true
        lable.font = .AAvanteBsExtraBold(size: UIScreen.main.bounds.width / 15)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let inf: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        lable.text = "info"
        lable.adjustsFontSizeToFitWidth = true
        lable.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 35
        addElementForView()
        addConstraintForView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func addElementForView() {
        contentView.addSubview(image)
        contentView.addSubview(dayWeek)
        contentView.addSubview(date)
        contentView.addSubview(degrees)
        contentView.addSubview(inf)
    }
    
    private func addConstraintForView() {
        NSLayoutConstraint.activate([
            dayWeek.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dayWeek.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            date.topAnchor.constraint(equalTo: dayWeek.bottomAnchor),
            date.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            image.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            //image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.89),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            degrees.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            degrees.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            inf.topAnchor.constraint(equalTo: degrees.bottomAnchor),
            inf.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            inf.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            ])
        dayWeek.setContentHuggingPriority(.defaultHigh, for: .vertical)
        date.setContentHuggingPriority(.defaultHigh, for: .vertical)
        image.setContentHuggingPriority(.defaultHigh, for: .vertical)
        degrees.setContentHuggingPriority(.defaultLow, for: .vertical)
   inf.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    func setup(model: ForecastCellModel?) {
        degrees.text = String(format: "%0.1f", model?.temp ?? 0)
        image.image = UIImage(named: updateImageMain(icon: model?.icon ?? ""))
    }
    
    func updateImageMain(icon: String) -> String {
        let value = icon
        switch value {
        case "01d":
            return "clearDay"
        case "01n":
            return "clearNight"
        case "02d":
            return "fewCloudsDay"
        case "02n":
            return "fewCloudsNight"
        case "03d", "03n":
            return "scatteredClouds"
        case "04d", "04n":
            return "clouds"
        case "09d", "09n":
            return "drizzle"
        case "10d", "10n":
            return "heavyRain"
        case "11d", "11n":
            return "thunderstorm"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "mist"
        default:
            return "dde"
        }
    }
}
