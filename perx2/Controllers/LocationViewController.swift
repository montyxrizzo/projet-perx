//
//  ViewController.swift
//  CustomTableView
//
//  Created by Belal Khan on 30/07/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import CoreLocation



//adding class DataSource and Delegate for our TableView
class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //networking
    lazy var googleClient: GoogleClientRequest = GoogleClient()
    //location
    var currentLocation: CLLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    var locationName : String = "Starbucks"
    var searchRadius : Int = 2500
    
    //the Web API URL
    let URL_GET_DATA = "https://simplifiedcoding.net/demos/marvel/"
    
    //our table view
    @IBOutlet weak var tableViewHeroes: UITableView!
    
    //a list to store places
    var heroes = [Hero]()
    var places = [Place]()

    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return places.count
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        fetchGoogleData(forLocation: currentLocation)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationViewControllerTableViewCell
    
        //getting the hero for the specified position
        let hero: Hero
        hero = heroes[indexPath.row]
        let place: Place
        place = places[indexPath.row]
        
        //displaying values
        cell.labelName.text = place.name
        cell.labelTeam.text = place.address
        
        
//        //displaying image
//        Alamofire.request(hero.imageUrl!).responseImage { response in
//            debugPrint(response)
//        
//            if let image = response.result.value {
//                cell.heroImage.image = image
//            }
//        }
        
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGoogleData(forLocation: currentLocation)

     
        //fetching data from web api
        googleClient.getGooglePlacesData(forKeyword: "Starbucks", location: currentLocation, withinMeters: 2500) { (response) in
            
        

                }
                
        //displaying data in tableview



        self.tableViewHeroes.reloadData()
// Do any additional setup after loading the view, typically from a nib.
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


}

extension LocationViewController {
    func fetchGoogleData(forLocation: CLLocation) {
        //guard let location = currentLocation else { return }
        googleClient.getGooglePlacesData(forKeyword: "Starbucks", location: currentLocation, withinMeters: 2500) { (response) in
            
            self.printFirstFive(places: response.results)
            
        }
    }
    
    func printFirstFive(places: [Place]) {
        for place in places.prefix(5) {
            print("*******NEW PLACE********")
            let name = place.name
            let address = place.address
            let location = ("lat: \(place.geometry.location.latitude), lng: \(place.geometry.location.longitude)")
            guard let open = place.openingHours?.open  else {
                print("\(name) is located at \(address), \(location)")
                return
            }
            if open {
                print("\(name) is open, located at \(address), \(location)")
            } else {
                print("\(name) is closed, located at \(address), \(location)")
            }
        }
    }
}


