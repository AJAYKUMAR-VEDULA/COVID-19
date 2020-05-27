//
//  StateWiseReport.swift
//  COVID-19
//
//  Created by AJ on 30/04/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

struct StateWiseReport : Decodable {
    var state : String
    var confirmed : String
    var recovered : String
    var deaths : String
    var active : String
    var lastupdatedtime : String
    var deltaconfirmed : String
    var deltarecovered : String
    var deltadeaths : String
    var statecode : String
    var statenotes : String
}
