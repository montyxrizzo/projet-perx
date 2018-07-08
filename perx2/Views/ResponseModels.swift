//
//  ResponseModels.swift
//  perx2
//
//  Created by Montreaux Rodgers on 7/7/18.
//  Copyright © 2018 Montreaux Rodgers. All rights reserved.
//

import Foundation

//a
struct GooglePlacesResponse : Codable {
    //b
    let results : [Place]
    //c
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
a
