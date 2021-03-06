//
//  FindSensorController.swift
//  Dashboard
//
//  Created by Philipp Tschauner on 11.06.17.
//  Copyright © 2017 Philipp Tschauner. All rights reserved.
//

import UIKit
import CoreLocation

class SensorLibraryController: UICollectionViewController {
    
    
    let sensors: [DeviceModel] = [
        
        DeviceModel(name: "KR QUANTEC ultra", sensors: [
            
            SensorModel(id: "ss", type: .Temperatur, entity: .Temperatur, value: -2, minValue: 0, maxValue: 50, time: "Heute: 13:10"),
           SensorModel(id: "ss", type: .Lautstärke, entity: .Lautstärke, value: 60, minValue: 0, maxValue: 50, time: "Heute: 13:10"),
           SensorModel(id: "ss", type: .Kohlenmonoxid, entity: .Kohlenmonoxid, value: 48.6, minValue: 0, maxValue: 150, time: "Heute: 13:10")], image: "roboter1", minorValue: 14042),
        
        DeviceModel(name: "ABB IRB 5400", sensors: [
            
            SensorModel(id: "ss", type: .Temperatur, entity: .Temperatur, value: -2, minValue: 0, maxValue: 50, time: "Heute: 13:10"),
            SensorModel(id: "ss", type: .Lautstärke, entity: .Lautstärke, value: 60, minValue: 0, maxValue: 50, time: "Heute: 13:10"),
            SensorModel(id: "ss", type: .Kohlenmonoxid, entity: .Kohlenmonoxid, value: 48.6, minValue: 0, maxValue: 150, time: "Heute: 13:10")], image: "roboter2", minorValue: 6333),
        
        DeviceModel(name: "ABB IRB 5400", sensors: [
            
            SensorModel(id: "ss", type: .Temperatur, entity: .Temperatur, value: -2, minValue: 0, maxValue: 50, time: "Heute: 13:10"),
            SensorModel(id: "ss", type: .Lautstärke, entity: .Lautstärke, value: 60, minValue: 0, maxValue: 50, time: "Heute: 13:10"),
            SensorModel(id: "ss", type: .Kohlenmonoxid, entity: .Kohlenmonoxid, value: 48.6, minValue: 0, maxValue: 150, time: "Heute: 13:10")], image: "roboter3", minorValue: 6179),
        
        DeviceModel(name: "ABB IRB 5400", sensors: [
            
            SensorModel(id: "ss", type: .Temperatur, entity: .Temperatur, value: -2, minValue: 0, maxValue: 50, time: "Heute: 13:10"),
            SensorModel(id: "ss", type: .Lautstärke, entity: .Lautstärke, value: 60, minValue: 0, maxValue: 50, time: "Heute: 13:10"),
            SensorModel(id: "ss", type: .Kohlenmonoxid, entity: .Kohlenmonoxid, value: 48.6, minValue: 0, maxValue: 150, time: "Heute: 13:10")], image: "roboter", minorValue: 5555)
    ]

    let cellId = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        
        setupCollectionView()
        
        setupHeaderView()
    
        navigationController?.navigationBar.tintColor = UIColor(white: 0, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(white: 1, alpha: 1)
        
        // remove the shadow
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    // setup collection view
    
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: 180, height: 150)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.register(SensorLibraryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func showORScanner() {
        
        let qrcode = ScannerController()
        
        present(qrcode, animated: true, completion: nil)
    }
    
    
    
    func showOptions() {
        
        let noAction = UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil)
        let qrAction = UIAlertAction(title: "QR Code scannen", style: .default) { (action) in
            
            self.showORScanner()
        }
        
        let beaconAction = UIAlertAction(title: "iBeacon anlegen", style: .default) { (action) in
            
            self.showAddSensorController()
        }
        
        showAlertSheet(title: "", contentText: "Sie haben die Möglichkeit den Sensor über einen \nQR Code oder per iBeacon hinzufügen.", actions: [qrAction, beaconAction, noAction])
    }
    
    
    var headlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nicht dabei? Hier können Sie den Sensor manuell hinzufügen."
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Hinzufügen", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(white: 0, alpha: 0.06)
        button.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
        return button
    }()
    
    
    func dismissView() {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func showAddSensorController() {
        
        let addSensor = AddSensorController()
        
        navigationController?.pushViewController(addSensor, animated: true)
//        present(nav, animated: true, completion: nil)
    }
    
    func showSensorDetailViewController(with device: DeviceModel) {
        
        let sensorDetail = SensorDetailViewController()
        sensorDetail.device = device
        
        navigationController?.pushViewController(sensorDetail, animated: true)
        
    }
    
    
    func setupHeaderView() {
        
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(white: 0, alpha: 0)
        
        view.addSubview(headlineLabel)
        view.addSubview(okButton)
        view.addSubview(line)
        
        headlineLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        headlineLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        headlineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        okButton.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 20).isActive = true
        okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        line.topAnchor.constraint(equalTo: okButton.bottomAnchor, constant: 15).isActive = true
        line.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        line.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
    }
    
}

extension SensorLibraryController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SensorLibraryCell
        
        cell.device = sensors[indexPath.item]
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sensors.count
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        return CGSize(width: view.frame.width, height: 140)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.bounds.size.width)
        
        return CGSize(width: itemWidth, height: 90)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selected = sensors[indexPath.item]
        
        showSensorDetailViewController(with: selected)
        
    }
    
}


