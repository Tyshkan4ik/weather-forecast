//
//  Forecast10Days.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 07.11.2022.
//

import Foundation
import UIKit

class Forecast10Days: UITableViewCell {
    
    private var thirdSectionModel: ForecastCellModel?
    
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.9411764706, blue: 0.9803921569, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        //collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
                layout.scrollDirection = .horizontal
        collection.register(CollectionDayCell.self, forCellWithReuseIdentifier: CollectionDayCell.identifier)
        layout.minimumLineSpacing = 12
        //collection.layer.cornerRadius = 20
       layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        
        return collection
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        addConstraint()
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.9411764706, blue: 0.9803921569, alpha: 1)
        selectionStyle = .none
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
            //collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    var test: [ForecastCellModel]?
    
    func setup1(model: [ForecastCellModel]?) {
        test = model
        collectionView.reloadData()
    }
    
}

extension Forecast10Days: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDayCell.identifier, for: indexPath) as! CollectionDayCell
        
//        myCell.backgroundView = GradientView2(colors: [UIColor(red:105/255, green:225/255, blue:213/255, alpha:1).cgColor, UIColor(red:0/255, green:173/255, blue:255/255, alpha:1).cgColor])
        let dodo = test?[indexPath.row]
        myCell.setup(model: dodo)
        return myCell
    }
    
}

//extension Forecast10Days: UICollectionViewDelegate {}

extension Forecast10Days: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: collectionView.frame.height)
    }
    
}
