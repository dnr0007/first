//
//  Map.swift
//  Module
//
//  Created by vishal singh on 10/09/18.
//  Copyright © 2018 vishal singh. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces



class Map: UIViewController,GMSMapViewDelegate, UISearchBarDelegate , LocateOnTheMap,GMSAutocompleteFetcherDelegate {
    

    var currentZoom:Float = 10
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!


    
    @IBOutlet weak var map_view: GMSMapView!
    
    public func didFailAutocompleteWithError(_ error: Error) {
        
    }
    
    
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 4.0)
        map_view.camera = camera
        map_view.isMyLocationEnabled = true
        map_view.delegate = self
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = map_view
        map_view.isMyLocationEnabled = true
        map_view.settings.myLocationButton = true
       

        // Do any additional setup after loading the view.
    }
  

   
    
    func root() {
        let origin = "\(-33.86),\(151.20)"
        let destination = "\(-34.2740889343792),\(149.68937985599)"
        
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            
    //        print(data,"\n",response)
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    let routes = json["routes"] as! NSArray
                    //self.mapView.clear()
                    
                    OperationQueue.main.addOperation({
                        for route in routes
                        {
                            let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
                            let points = routeOverviewPolyline.object(forKey: "points")
                            let path = GMSPath.init(fromEncodedPath: points! as! String)
                            let polyline = GMSPolyline.init(path: path)
                            polyline.strokeWidth = 3
                            
                            let bounds = GMSCoordinateBounds(path: path!)
                            self.map_view.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
                            
                            polyline.map = self.map_view
                            
                        }
                    })
                }catch let error as NSError{
                    print("error:\(error)")
                }
            }
        }).resume()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = map_view
    }
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        
        
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.map_view.camera = camera
            
            marker.title = "Address : \(title)"
            marker.map = self.map_view
            
        }
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
        
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchBar.delegate = self
        
        
        
        self.present(searchController, animated:true, completion: nil)
        
    }
    @IBAction func zoomIn(_ sender: UIButton) {
        currentZoom = currentZoom + 1;
        print("Plus")
        
        self.map_view.animate(toZoom: currentZoom)
    }
    
    @IBAction func zoomOut(_ sender: UIButton) {
        currentZoom = currentZoom - 1;
        print("Minus")
        
        self.map_view.animate(toZoom: currentZoom)
    }
}

