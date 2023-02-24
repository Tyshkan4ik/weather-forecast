//
//  InfoCell.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 03.11.2022.
//

import Foundation
import UIKit

protocol InfoCellDelegate: AnyObject {
    func showMore(_ cell: InfoCell)
    func update(_ cell: InfoCell)
}

class InfoCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    weak var delegate: InfoCellDelegate?
    
    let backgroundInfoView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let moreButton: UIButton = {
       let button = UIButton()

        button.setTitle("Подробнее ⟫", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = .IntuitionsskBold(size: UIScreen.main.bounds.width / 23)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.alpha = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let updateButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 20, weight: .medium, scale: .default)
        let image = UIImage(systemName: "arrow.clockwise", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let stackViewSecond: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let element1 = Element()
    let element2 = Element()
    let element3 = Element()
    
    let element4 = Element(), element5 = Element(), element6 = Element()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addNewElement()
        addConstraint()
        backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.9411764706, blue: 0.9803921569, alpha: 1)
        selectionStyle = .none
        moreButton.addTarget(self, action: #selector(onMoreViewController), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(tuchUpdate), for: .touchUpInside)
    }
    
    @objc func onMoreViewController() {
        delegate?.showMore(self)
    }
    
    @objc func tuchUpdate() {
        delegate?.update(self)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func addNewElement() {
        contentView.addSubview(backgroundInfoView)
        backgroundInfoView.addSubview(moreButton)
        backgroundInfoView.addSubview(updateButton)
//        backgroundInfoView.addSubview(element1)
//        backgroundInfoView.addSubview(element2)
//        backgroundInfoView.addSubview(element3)
        backgroundInfoView.addSubview(stackView)
        backgroundInfoView.addSubview(stackViewSecond)
        stackView.addArrangedSubview(element1)
        stackView.addArrangedSubview(element2)
        stackView.addArrangedSubview(element3)
        stackViewSecond.addArrangedSubview(element4)
        stackViewSecond.addArrangedSubview(element5)
        stackViewSecond.addArrangedSubview(element6)
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            backgroundInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            backgroundInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backgroundInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            backgroundInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            moreButton.topAnchor.constraint(equalTo: backgroundInfoView.topAnchor, constant: 20),
            moreButton.leadingAnchor.constraint(equalTo: backgroundInfoView.leadingAnchor, constant: 20),
            
            updateButton.topAnchor.constraint(equalTo: backgroundInfoView.topAnchor, constant: 20),
            updateButton.trailingAnchor.constraint(equalTo: backgroundInfoView.trailingAnchor, constant: -25),
            //updateButton.heightAnchor.constraint(equalTo: backgroundInfoView.heightAnchor, multiplier: 1/5),
            //updateButton.widthAnchor.constraint(equalTo: updateButton.heightAnchor),
            
//            element1.topAnchor.constraint(equalTo: moreLabel.bottomAnchor, constant: 30),
//            element1.leadingAnchor.constraint(equalTo: backgroundInfoView.leadingAnchor, constant: 10),
//            element1.widthAnchor.constraint(equalTo: backgroundInfoView.widthAnchor, multiplier: 1/5),
//            element1.heightAnchor.constraint(equalTo: element1.widthAnchor),
//            element1.bottomAnchor.constraint(equalTo: backgroundInfoView.bottomAnchor),
            
//            element2.topAnchor.constraint(equalTo: moreLabel.bottomAnchor, constant: 30),
//            element2.leadingAnchor.constraint(equalTo: element1.trailingAnchor, constant: 10),
//            element1.widthAnchor.constraint(equalTo: backgroundInfoView.widthAnchor, multiplier: 1/5),
//            element1.heightAnchor.constraint(equalTo: element1.widthAnchor),
//            element2.bottomAnchor.constraint(equalTo: backgroundInfoView.bottomAnchor),
            
//            element3.topAnchor.constraint(equalTo: moreLabel.bottomAnchor, constant: 30),
//            element3.leadingAnchor.constraint(equalTo: element2.trailingAnchor, constant: 10),
//            element1.widthAnchor.constraint(equalTo: backgroundInfoView.widthAnchor, multiplier: 1/5),
//            element1.heightAnchor.constraint(equalTo: element1.widthAnchor),
//            element3.bottomAnchor.constraint(equalTo: backgroundInfoView.bottomAnchor)
            
            stackView.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: backgroundInfoView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: backgroundInfoView.trailingAnchor),
            
            stackViewSecond.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            stackViewSecond.leadingAnchor.constraint(equalTo: backgroundInfoView.leadingAnchor),
            stackViewSecond.trailingAnchor.constraint(equalTo: backgroundInfoView.trailingAnchor),
            stackViewSecond.bottomAnchor.constraint(equalTo: backgroundInfoView.bottomAnchor, constant: -20)
        ])
    }
    
    func setup(model: InfoCellModel?) {
        element1.setup(model: model?.element1)
        element2.setup(model: model?.element2)
        element3.setup(model: model?.element3)
        element4.setup(model: model?.element4)
        element5.setup(model: model?.element5)
        element6.setup(model: model?.element6)
    }
    
}
