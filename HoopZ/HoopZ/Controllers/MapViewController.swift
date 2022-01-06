//
//  MapViewController.swift
//  HoopZ
//
//  Created by dadDev on 5/30/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostViewModel.instance.getLocationData()
//

        testmapdata()
        
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//      var pv =  PostViewModel.instance
//        let _annotation = MKPointAnnotation()
//        _annotation.coordinate = CLLocationCoordinate2D(latitude: pv.testLocations.count == 0 ? 37.33233141 : PostViewModel.instance.testLocations[0].lat, longitude:pv.testLocations.count == 0 ? -122.4056973 :  PostViewModel.instance.testLocations[0].long)
//
//        _annotation.title = pv.testLocations.count == 0 ? "test spot" :
//            PostViewModel.instance.testLocations[0].name
//
//
//        mapView.addAnnotation(_annotation)
//        _annotation.coordinate = CLLocationCoordinate2D(latitude:pv.testLocations.count == 0 ? 37.33233141 : PostViewModel.instance.testLocations[1].lat, longitude: pv.testLocations.count == 0 ? -122.4056973 : PostViewModel.instance.testLocations[1].long)
//
//        _annotation.title = pv.testLocations.count == 0 ? "test spot 2" :
//            PostViewModel.instance.testLocations[1].name
//        mapView.addAnnotation(_annotation)
//
//        let region = MKCoordinateRegion(center: _annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//
//        mapView.setRegion(region, animated: true)
    }
    
    
    func testmapdata() -> Void {
        let pv =  PostViewModel.instance
        
        var pvList = pv.testLocations
        let _annotation = MKPointAnnotation()
       
        pvList.forEach { testlocation in
            _annotation.coordinate = CLLocationCoordinate2D(latitude: pv.testLocations.count == 0 ? 37.33233141 : testlocation.lat, longitude:pv.testLocations.count == 0 ? -122.4056973 :  testlocation.long)
            
            _annotation.title = testlocation.name
            mapView.addAnnotation(_annotation)
            
           
        }
        
        let region = MKCoordinateRegion(center: _annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        
        mapView.setRegion(region, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
