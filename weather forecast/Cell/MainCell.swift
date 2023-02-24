//
//  MainCell.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 24.10.2022.
//

import Foundation
import UIKit


final class MainCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let backgroundMainCell: GradientView = {
        var view = GradientView(colors: [UIColor(red:105/255, green:225/255, blue:213/255, alpha:1).cgColor, UIColor(red:0/255, green:173/255, blue:255/255, alpha:1).cgColor])
        //view.backgroundColor = #colorLiteral(red: 0.04704800993, green: 0.8955746889, blue: 0.7673335671, alpha: 1)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imagePartlyCloudy: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "fewCloudsDay")
        imageView.image = image
        //imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let imageNoWind: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "сильный ветер")
        imageView.image = image
        imageView.alpha = 0.2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titlCity: UILabel = {
       let lable = UILabel()
        lable.textColor = .white
        //lable.numberOfLines = 1
        //lable.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width / 20)
        lable.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 20)
        lable.adjustsFontSizeToFitWidth = true
        //lable.text = "Санкт-Петербург"
        lable.alpha = 0.8
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    lazy var dayOfTheWeek: UILabel = {
       let label = UILabel()
        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: bounds.width / 14)
        label.adjustsFontSizeToFitWidth = true
        //label.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width / 32 )
        label.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 32)
        //label.text = "Понедельник,"
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = selectionTimeZone(valueTimeZone: timeZoneValue)
//        dateFormatter.dateFormat = "EEEE"
//                let weekDay = dateFormatter.string(from: Date())
//        label.text = weekDay.capitalized
        label.alpha = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeZoneValue: Int = 0
    
//    func selectionTimeZone(valueTimeZone: Int) -> TimeZone {
//        let value = valueTimeZone
//        return NSTimeZone(forSecondsFromGMT: value) as TimeZone
//    }
    
    func selectionDayOfWeek(valueT: Int) -> String {
        let dateFormatter = DateFormatter()
        let value = valueT
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: value) as TimeZone
        dateFormatter.dateFormat = "EEEE"
                let weekDay = dateFormatter.string(from: Date())
        return weekDay.capitalized
    }
    
    func selectionDate(valueT: Int) -> String {
        let dateFormatter = DateFormatter()
        let value = valueT
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: value) as TimeZone
        dateFormatter.dateFormat = "dd/MM"
                let date = dateFormatter.string(from: Date())
        return date
    }
    
   lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        //label.text = "02/11"
//       let dateFormatter = DateFormatter()
       //dateFormatter.timeZone = selectionTimeZone(valueTimeZone: timeZoneValue)

//       dateFormatter.dateFormat = "dd/MM"
//               let date = dateFormatter.string(from: Date())
//       label.text = date
       label.alpha = 0.6
        label.adjustsFontSizeToFitWidth = true
       //label.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width / 32 )
       label.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let degreesOnView: UILabel = {
       let lable = UILabel()
        lable.textColor = .white
        //lable.text = "-5°"
        lable.adjustsFontSizeToFitWidth = true
        lable.alpha = 0.9
        //lable.font = .MysteriaNouveau(size: UIScreen.main.bounds.width / 5.8)
        lable.font = .AAvanteBsExtraBold(size: UIScreen.main.bounds.width / 5.8)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addNewElement()
        addConstraintElement()
        backgroundColor = #colorLiteral(red: 0.8398272395, green: 0.9403695464, blue: 0.9815813899, alpha: 1)
        //убираем выделение при клике
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        titlCity.font = UIFont.systemFont(ofSize: bounds.width / 4)
//    }
    
    private func addNewElement() {
        contentView.addSubview(backgroundMainCell)
        backgroundMainCell.addSubview(imagePartlyCloudy)
        backgroundMainCell.addSubview(titlCity)
        backgroundMainCell.addSubview(degreesOnView)
        backgroundMainCell.addSubview(imageNoWind)
        backgroundMainCell.addSubview(dayOfTheWeek)
        backgroundMainCell.addSubview(dateLabel)
    }

    private func addConstraintElement() {
        NSLayoutConstraint.activate([
            
            backgroundMainCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            backgroundMainCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backgroundMainCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            backgroundMainCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imagePartlyCloudy.leadingAnchor.constraint(equalTo: backgroundMainCell.leadingAnchor, constant: 25),
            imagePartlyCloudy.topAnchor.constraint(equalTo: backgroundMainCell.topAnchor, constant: -25),
            imagePartlyCloudy.widthAnchor.constraint(equalTo: backgroundMainCell.widthAnchor, multiplier: 1/2.5),
            imagePartlyCloudy.heightAnchor.constraint(equalTo: imagePartlyCloudy.widthAnchor),
            
            titlCity.topAnchor.constraint(equalTo: imagePartlyCloudy.bottomAnchor),
            titlCity.leadingAnchor.constraint(equalTo: backgroundMainCell.leadingAnchor, constant: 30),
            titlCity.trailingAnchor.constraint(equalTo: imageNoWind.leadingAnchor),
            
            dayOfTheWeek.topAnchor.constraint(equalTo: titlCity.bottomAnchor),
            dayOfTheWeek.leadingAnchor.constraint(equalTo: backgroundMainCell.leadingAnchor, constant: 30),
            dayOfTheWeek.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -5),
            dayOfTheWeek.bottomAnchor.constraint(equalTo: backgroundMainCell.bottomAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: titlCity.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: imageNoWind.leadingAnchor),
            
            degreesOnView.trailingAnchor.constraint(equalTo: backgroundMainCell.trailingAnchor, constant: -30),
            degreesOnView.topAnchor.constraint(equalTo: backgroundMainCell.topAnchor, constant: 15),
            
            imageNoWind.bottomAnchor.constraint(equalTo: backgroundMainCell.bottomAnchor, constant: -UIScreen.main.bounds.width / 35),
            imageNoWind.trailingAnchor.constraint(equalTo: backgroundMainCell.trailingAnchor, constant: -UIScreen.main.bounds.width / 9),
            imageNoWind.widthAnchor.constraint(equalTo: backgroundMainCell.widthAnchor, multiplier: 1/6),
            imageNoWind.heightAnchor.constraint(equalTo: imageNoWind.widthAnchor)
            
        ])
        dayOfTheWeek.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageNoWind.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func setup(model: CityModel?) {
        titlCity.text = model?.firstSectionModel?.city
        print(model?.firstSectionModel?.city)
        degreesOnView.text = model?.firstSectionModel?.temp
        //timeZoneValue = model?.timeZone ?? 0
        dayOfTheWeek.text = selectionDayOfWeek(valueT: model?.firstSectionModel?.timeZone ?? 0)
        dateLabel.text = selectionDate(valueT: model?.firstSectionModel?.timeZone ?? 0)
        imagePartlyCloudy.image = UIImage(named: updateImageMain(icon: model?.firstSectionModel?.weatherIcon ?? ""))
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

//AAvanteBsExtraBold
//BenguiatMediumItalic
//MysteriaNouveau

extension
 Date {
    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
         let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
         return addingTimeInterval(delta)
    }
}
