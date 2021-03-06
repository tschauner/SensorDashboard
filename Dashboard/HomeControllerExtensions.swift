//
//  HomeControllerDelegates.swift
//  Dashboard
//
//  Created by Philipp Tschauner on 17.06.17.
//  Copyright © 2017 Philipp Tschauner. All rights reserved.
//

import UIKit


// Delegates

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SensorTileCell
        cell.sensor = incomingData[indexPath.item]
        
        let va = cell.sensor?.value ?? 0
        let mi = cell.sensor?.minValue ?? 0
        let ma = cell.sensor?.maxValue ?? 50
        
        let time = currentTimeString()
        
        
        UIView.animate(withDuration: 0.8) {
            
            switch (va, mi, ma) {
            case let (value, _, max) where value > max:
                
                cell.colorView.backgroundColor = self.maxColor
                cell.errorLabel.isHidden = false
                
                EventsCV.events.insert(EventModel(type: cell.sensor!.type.rawValue, time: time, text: .Max), at: 0)
                self.showAlert(with: EventModel(type: cell.sensor!.type.rawValue, time: time, text: .Max))
                // wenn der wert größer als der max wert ist
                
            case let (value, min, _) where value < min:
                
                cell.colorView.backgroundColor = self.minColor
                cell.errorLabel.isHidden = false
                
                EventsCV.events.insert(EventModel(type: cell.sensor!.type.rawValue, time: time, text: .Min), at: 0)
                self.showAlert(with: EventModel(type: cell.sensor!.type.rawValue, time: time, text: .Min))
                
                // wenn der wert kleiner als der min wert ist
                
                
            default:
                cell.errorLabel.isHidden = true
                
            }
        }
        
        headerView.eventBar.collectionView.reloadData()
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if incomingData.count == 0 {
            
            collectionView.backgroundView = backGroundView()
            
            return 0
        } else {
            
            collectionView.backgroundView = UIView()
            return incomingData.count
            
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        return CGSize(width: view.frame.width, height: 140)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.bounds.size.width  / 2)
        
        return CGSize(width: itemWidth - 16, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // falls man mit der geklicken cell was anstellen will
        if let cell = collectionView.cellForItem(at: indexPath) as? SensorTileCell {
            
            
            let data = incomingData[indexPath.item]
            
            
            show(sensorData: data)
            
            
            
        }
        
    }
    
}

// Background view

extension HomeController {
    
    func backGroundView() -> UIView {
        
        
        let containerView = UIView()
        containerView.frame = view.bounds
        containerView.center = CGPoint(x: view.center.x - 30, y: view.center.y - 80)
        
        containerView.backgroundColor = .darkGray
        
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.text = "Keine Sensoren\nin Reichweite"
        
        
        
        let size: CGFloat = 50
        let scalefactor: CGFloat = 8

        
        let shapeView = UIView(frame: CGRect(x: containerView.center.x, y: containerView.center.y, width: size, height: size))
        shapeView.layer.borderWidth = 0.4
        shapeView.backgroundColor = UIColor(white: 1, alpha: 0.2)
        shapeView.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        shapeView.layer.cornerRadius = 25
        shapeView.isHidden = true
        
        
        // first ring
        
        UIView.animate(withDuration: 1.8, delay: 0, options: [.curveEaseOut, .repeat], animations: {
            
            shapeView.isHidden = false
            shapeView.transform = CGAffineTransform(scaleX: scalefactor, y: scalefactor)
            shapeView.alpha = 0
            
            
        }, completion: nil)
        
        let shapeView2 = UIView(frame: CGRect(x: containerView.center.x, y: containerView.center.y, width: size, height: size))
        shapeView2.layer.borderWidth = 0.4
        shapeView2.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        shapeView2.backgroundColor = UIColor(white: 1, alpha: 0.2)
        shapeView2.layer.cornerRadius = 25
        shapeView2.isHidden = true
        
        containerView.addSubview(shapeView2)
        
        
        // second ring
        
        UIView.animate(withDuration: 1.8, delay: 1, options: [.curveEaseOut, .repeat], animations: {
            
            shapeView2.isHidden = false
            shapeView2.transform = CGAffineTransform(scaleX: scalefactor, y: scalefactor)
            shapeView2.alpha = 0
            
        }, completion: nil)
        
        
        containerView.addSubview(shapeView)
        containerView.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 10).isActive = true
        label.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -100).isActive = true
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        
        return containerView
    }
    
}



