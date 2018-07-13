//
//  Location.swift
//  perx2
//
//  Created by Montreaux Rodgers on 7/7/18.
//  Copyright © 2018 Montreaux Rodgers. All rights reserved.
//

struct Location {
    
    var lat: Double
    var long: Double
    var id: String?
    var name: String
    var vicinity: String
    var openNow: Int?
    var photos: [[String : Any]]?
    var placeID: String?
    var priceLevel: Int?
    var rating: Double?
    var types: [String]?
    
    init?(lat: Double, long: Double, id: String?, name: String,  vicinity: String, openNow: Int?, photos: [[String : Any]]?, placeID: String?, priceLevel: Int?, rating: Double?, types: [String]?) {
        self.lat = lat
        self.long = long
        self.id = id
        self.name = name
        self.vicinity = vicinity
        self.openNow = openNow
        self.photos = photos
        self.placeID = placeID
        self.priceLevel = priceLevel
        self.rating = rating
        self.types = types
    }
}
