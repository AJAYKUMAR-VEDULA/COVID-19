//
//  Delta.swift
//  COVID-19
//
//  Created by AJ on 30/04/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

struct Delta: Decodable {
    var confirmed : Int
    var deceased : Int
    var recovered : Int
}
