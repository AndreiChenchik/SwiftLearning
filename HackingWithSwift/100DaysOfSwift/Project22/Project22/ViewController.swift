//
//  ViewController.swift
//  Project22
//
//  Created by Andrei Chenchik on 3/6/21.
//
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    let myBeacons = [
        "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5": "Apple 54",
        "74278BDA-B644-4520-8F0C-720EAF059935": "Apple 74",
        "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0": "Apple E2"
    ]
    
    
    var detectionAlertShown = false
    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var beaconName: UILabel!
    @IBOutlet var distanceIndicator: UIView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        distanceIndicator.layer.cornerRadius = 100
        distanceIndicator.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        for beacon in myBeacons {
            let uuid = UUID(uuidString: beacon.key)!
            let beaconRegion = CLBeaconRegion(uuid: uuid, identifier: beacon.value)
            let beaconConstraint = CLBeaconIdentityConstraint(uuid: uuid)
            locationManager?.startMonitoring(for: beaconRegion)
            locationManager?.startRangingBeacons(satisfying: beaconConstraint)
        }
    }
    
    func update(distance: CLProximity, name: String? = "") {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                self.beaconName.text = name
                self.distanceIndicator.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                self.beaconName.text = name
                self.distanceIndicator.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                self.beaconName.text = name
                self.distanceIndicator.transform = CGAffineTransform(scaleX: 1, y: 1)
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
                self.beaconName.text = ""
                self.distanceIndicator.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            }
        }
    }
    
    fileprivate func showDetectionAlert() {
        if !detectionAlertShown {
            let beaconDetectedAC = UIAlertController(title: "Your beacon detected", message: "Hurray!", preferredStyle: .alert)
            beaconDetectedAC.addAction(UIAlertAction(title: "Understood", style: .default))
            
            present(beaconDetectedAC, animated: true)
            detectionAlertShown = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
    
        if let beacon = beacons.first {
            showDetectionAlert()
            update(distance: beacon.proximity, name: myBeacons[beacon.uuid.uuidString])
        }
    }
}

