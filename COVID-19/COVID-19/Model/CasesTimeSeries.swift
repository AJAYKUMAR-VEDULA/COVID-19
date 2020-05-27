//
//  CasesTimeSeries.swift
//  COVID-19
//
//  Created by AJ on 27/05/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

struct CasesTimeSeries : Decodable{
    var dailyconfirmed: String
    var dailydeceased: String
    var dailyrecovered:String
    var date: String
    var totalconfirmed : String
    var totaldeceased : String
    var totalrecovered : String
}
