/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

import MapKit
import CoreLocation

extension ViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if locations.count > 0 {
      let location = locations.last!
      print("Accuracy: \(location.horizontalAccuracy)")
      
      if location.horizontalAccuracy < 100 {
        manager.stopUpdatingLocation()
        let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.region = region
        if !startedLoadingPOIs {
          startedLoadingPOIs = true
          //2
          let loader = PlacesLoader()
          loader.loadPOIS(location: location, radius: 1000) { placesArray, error in
            //3
            if let array = placesArray {
              //1
              for placeDict in array {
                //3
                let latitude = placeDict.value(forKeyPath: "latitude") as! CLLocationDegrees
                let longitude = placeDict.value(forKeyPath: "longitude") as! CLLocationDegrees
                let name = placeDict.object(forKey: "name") as! String
                let address = placeDict.object(forKey: "address") as! String
                let rt = placeDict.object(forKey: "rating") as! NSArray
                let rating = rt[0] as! Double
                let price_level = placeDict.object(forKey: "price_level") as! Int
                
                let location = CLLocation(latitude: latitude, longitude: longitude)
                //4
                let place = Place(location: location, name: name, address: address, price_level: price_level, rating: rating)
                self.places.append(place)
                //5
                let annotation = PlaceAnnotation(location: place.location!.coordinate, title: place.placeName)
                //6
                DispatchQueue.main.async {
                  self.mapView.addAnnotation(annotation)
                }
              }
            }
          }
        }
      }
    }
  }
}

extension ViewController: ARDataSource {
  func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
    let annotationView = AnnotationView()
    annotationView.annotation = viewForAnnotation
    annotationView.delegate = self
    annotationView.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
    
    return annotationView
  }
}

extension ViewController: AnnotationViewDelegate {
  func didTouch(annotationView: AnnotationView) {
    let annotation = annotationView.annotation as! Place
    self.showInfoView(forPlace: annotation)
  }
}

class ViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  fileprivate let locationManager = CLLocationManager()
  fileprivate var startedLoadingPOIs = false
  fileprivate var places = [Place]()
  fileprivate var arViewController: ARViewController!
    
  override func viewDidLoad() {
    super.viewDidLoad()
        
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.startUpdatingLocation()
    locationManager.requestWhenInUseAuthorization()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func showARController(_ sender: Any) {
    arViewController = ARViewController()
    //1
    arViewController.dataSource = self
    //2
    arViewController.maxVisibleAnnotations = 30
    arViewController.headingSmoothingFactor = 0.05
    //3
    arViewController.setAnnotations(places)
    
    self.present(arViewController, animated: true, completion: nil)
  }
  
  func showInfoView(forPlace place: Place) {
    let alert = UIAlertController(title: place.placeName , message: place.infoText, preferredStyle: UIAlertControllerStyle.alert)
    let oneAction = UIAlertAction(title: "One", style: UIAlertActionStyle.default) { _ in }
    let twoAction = UIAlertAction(title: "Two", style: UIAlertActionStyle.default) { _ in }
    let threeAction = UIAlertAction(title: "Three", style: UIAlertActionStyle.default) { _ in }
    let fourAction = UIAlertAction(title: "Four", style: UIAlertActionStyle.default) { _ in }
    let fiveAction = UIAlertAction(title: "Five", style: UIAlertActionStyle.default) { _ in }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
    alert.addAction(oneAction)
    alert.addAction(twoAction)
    alert.addAction(threeAction)
    alert.addAction(fourAction)
    alert.addAction(fiveAction)
    alert.addAction(cancelAction)
    arViewController.present(alert, animated: true, completion: nil)
    return
  }
  
}

