//
//  Tested.swift
//  COVID-19
//
//  Created by AJ on 27/05/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

struct Tested : Decodable {
    var individualstestedperconfirmedcase: String
    var positivecasesfromsamplesreported: String
    var samplereportedtoday: String
    var source: String
    var testpositivityrate: String
    var testsconductedbyprivatelabs: String
    var testsperconfirmedcase: String
    var testspermillion: String
    var totalindividualstested: String
    var totalpositivecases: String
    var totalsamplestested: String
    var updatetimestamp: String
}
