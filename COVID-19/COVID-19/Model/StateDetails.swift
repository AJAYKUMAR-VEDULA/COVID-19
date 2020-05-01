//
//  StateDetails.swift
//  COVID-19
//
//  Created by AJ on 30/04/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

struct StateDetails: Decodable{
    var state : String
    var statecode : String
    var districtData : [District]
}
