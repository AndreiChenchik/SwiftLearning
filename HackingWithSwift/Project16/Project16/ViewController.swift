//
//  ViewController.swift
//  Project16
//
//  Created by Andrei Chenchik on 2/6/21.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "It was founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        title = "Some Capitals"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(changeMapStyle))
    }

    @objc func changeMapStyle() {
        let mapStyleAC = UIAlertController(title: "Choose map style", message: nil, preferredStyle: .actionSheet)
        mapStyleAC.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self] _ in self?.mapView.mapType = .hybrid }))
        mapStyleAC.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: { [weak self] _ in self?.mapView.mapType = .hybridFlyover }))
        mapStyleAC.addAction(UIAlertAction(title: "Muted Standard", style: .default, handler: { [weak self] _ in self?.mapView.mapType = .mutedStandard }))
        mapStyleAC.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { [weak self] _ in self?.mapView.mapType = .satellite }))
        mapStyleAC.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: { [weak self] _ in self?.mapView.mapType = .satelliteFlyover }))
        mapStyleAC.addAction(UIAlertAction(title: "Standard", style: .default, handler: { [weak self] _ in self?.mapView.mapType = .standard }))
        mapStyleAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(mapStyleAC, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .green
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
            annotationView?.pinTintColor = .green
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        guard let url = URL(string: "https://en.wikipedia.org/wiki/\(capital.title!)") else { fatalError("Can't build URL") }
        
        let webView = InfoViewController()
        webView.url = url
        
        navigationController?.pushViewController(webView, animated: true)

    }
}

