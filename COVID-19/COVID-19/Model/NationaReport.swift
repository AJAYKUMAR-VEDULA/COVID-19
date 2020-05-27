//
//  NationaReport.swift
//  COVID-19
//
//  Created by AJ on 27/05/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

struct NationaReport : Decodable {
    var cases_time_series : [CasesTimeSeries]
    var statewise : [StateWiseReport]
    var tested : [Tested]
}
