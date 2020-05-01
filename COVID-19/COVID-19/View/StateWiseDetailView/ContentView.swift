//
//  ContentView.swift
//  COVID-19
//
//  Created by AJ on 29/04/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    var stateWiseReportArray = [StateWiseReport]()
    var stateWiseDistrictData  = [StateDetails]()
    init() {
        guard let statsURL = URL(string: "https://api.covid19india.org/csv/latest/state_wise.csv") else {
            return
        }
        guard let districtURL = URL(string: "https://api.covid19india.org/v2/state_district_wise.json") else {
            return
        }
        let rowDelimiter = ","
        do {
            // CSV Parsing
            let content = try String(contentsOf: statsURL, encoding: String.Encoding.utf8)
            let rows : [String] = content.components(separatedBy: CharacterSet.newlines) as [String]
            for (index,column) in rows.enumerated() {
                if index%2 == 0 {
                    let coloumValues = column.components(separatedBy: rowDelimiter) as [String]
                    stateWiseReportArray.append(StateWiseReport(stateName: coloumValues[0], confirmed: coloumValues[1], recovered: coloumValues[2], deaths: coloumValues[3], active: coloumValues[4], lastUpdatedTime: coloumValues[5], deltaConfirmed: coloumValues[7], deltaRecovered: coloumValues[8], deltaDeaths: coloumValues[9], stateCode: coloumValues[6]))
                }
            }
            // JSON Parsing
            let districtContent = try Data(contentsOf: districtURL)
            let decoder = JSONDecoder()
            stateWiseDistrictData = try decoder.decode([StateDetails].self, from: districtContent)
        }
        catch {
            print(error)
        }
    }
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    AwarnessTiles()
                    VStack(alignment: .leading, spacing: 10){
                        Header()
                        TotalStats(headerTitle: stateWiseReportArray[0], totalStats: stateWiseReportArray[1])
                        StateWiseStats(stateWiseReportArray: stateWiseReportArray,stateWiseDistrictArray: stateWiseDistrictData)
                        Spacer()
                    }.padding(.bottom,10).background(Color.white).cornerRadius(30).shadow(radius: 10)
                }.background(Color.white)
            }.background(Color.white)
                .navigationBarTitle("").navigationBarHidden(true)
        }
    }
}

struct AwarnessTiles: View {
    var awarnessImages = ["Awarness2","Awarness1","Awarness3","Awarness4","Awarness5","Awarness6","Awarness7","Awarness8"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing : 0) {
                ForEach(awarnessImages, id: \.self) { awarnesImage in
                    Image(awarnesImage)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width-2,height: UIScreen.main.bounds.height/4).cornerRadius(10)
                        .padding(.horizontal,1)
                }
            }.padding(.horizontal,2)
        }
    }
}

struct Header: View {
    var body: some View {
        HStack(alignment: .center){
            Spacer()
            VStack(){
                Text("Covid19").modifier(textModifier(fontSize: 20, fontWeight: .heavy, statColor: Color.red))
                Text("INDIA").modifier(textModifier(fontSize: 16, fontWeight: .heavy, statColor: Color.blue))
            }
            Spacer()
        }.padding(.top,10)
    }
}

struct TotalStats: View {
    var headerTitle : StateWiseReport
    var totalStats : StateWiseReport
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack(alignment: .center) {
                statsView(statTitle: headerTitle.confirmed, statValue: totalStats.confirmed, deltaStat: totalStats.deltaConfirmed, statColor: Color.red)
                Spacer()
                statsView(statTitle: headerTitle.active, statValue: totalStats.active, deltaStat: "", statColor: Color.blue)
                Spacer()
                statsView(statTitle: headerTitle.recovered, statValue: totalStats.recovered,deltaStat: totalStats.deltaRecovered, statColor: Color.green)
                Spacer()
                statsView(statTitle: "Deceased", statValue: totalStats.deaths,deltaStat: totalStats.deltaDeaths, statColor: Color.black)
            }.padding(.horizontal,10).padding(.top,10)
            HStack(alignment: .center){
                Spacer()
                Text("Last Updated : \(totalStats.lastUpdatedTime)").modifier(textModifier(fontSize: 11, fontWeight: .medium, statColor: Color.black))
            }.padding(.trailing,10)
            
        }
        
    }
}

struct statsView: View {
    var statTitle : String
    var statValue : String
    var deltaStat : String
    var statColor : Color
    var body: some View {
        VStack(spacing: 10){
            Text(statTitle).modifier(textModifier(fontSize: 13, fontWeight: .heavy, statColor: statColor)).padding(.top, 10)
            Text(statValue).modifier(textModifier(fontSize: 13, fontWeight: .heavy, statColor: statColor))
            if statTitle != "Active" {
                Text("[+\(deltaStat)]").modifier(textModifier(fontSize: 11, fontWeight: .heavy, statColor: statColor))
            }
            Spacer()
        }.modifier(statsBorderModifier()).shadow(color: statColor, radius: 3)
    }
}





struct StateWiseStats: View {
    var stateWiseReportArray : [StateWiseReport]
    var stateWiseDistrictArray : [StateDetails]
    @State var seeAllButtonClicked : Bool = false
    @State var buttonTitle : String = "SeeAll"
    @State var showingTitle : String = "Top 5"
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            HStack(alignment: .center){
                Text("State Wise Report").modifier(textModifier(fontSize: 13, fontWeight: .semibold, statColor: Color.deepBlue))
                Spacer()
                Button(action: {
                    self.seeAllButtonClicked.toggle()
                    if self.seeAllButtonClicked {
                        self.buttonTitle = "Hide"
                        self.showingTitle = "All"
                    } else {
                        self.buttonTitle = "See All"
                        self.showingTitle = "Top 5"
                    }
                    
                }){
                    Text(buttonTitle).modifier(textModifier(fontSize: 13, fontWeight: .semibold, statColor: Color.deepBlue))
                }
            }
            Text("Now Showing \(showingTitle) States").modifier(textModifier(fontSize: 10, fontWeight: .semibold, statColor: Color.red))
            stateHeader(headerTitle: stateWiseReportArray[0])
            stateStats(stateWiseReportArray: stateWiseReportArray,stateWiseDistrictArray: stateWiseDistrictArray,seeAllbuttonClicked: seeAllButtonClicked)
            HStack(alignment: .center) {
                Spacer()
                Text("* Click On State Name for Details").modifier(textModifier(fontSize: 10, fontWeight: .semibold, statColor: Color.blue))
            }
        }.padding(.horizontal,10).padding(.top,10)
    }
}

struct stateHeader: View {
    var headerTitle : StateWiseReport
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            HStack(alignment: .center){
                Text(headerTitle.stateName).modifier(textModifier(fontSize: 10, fontWeight: .semibold, statColor: Color.blackPearl)).padding(.leading,5)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width/(25/5) - 8 ).padding(.vertical,5).background(Color.lightgray).cornerRadius(5)//
            headerText(text: headerTitle.confirmed,color: Color.lightgray)
            headerText(text: headerTitle.active,color: Color.lightgray)
            headerText(text: headerTitle.recovered,color: Color.lightgray)
            headerText(text: "Deceased",color: Color.lightgray)
        }
    }
}

struct headerText: View {
    var text: String
    var color : Color
    var deltaColor : Color?
    var deltaStat : String?
    var body: some View {
        HStack(alignment: .center){
            if color ==  Color.pearlBlue{
                if deltaStat != "0" {
                    Text("^\(deltaStat ?? "")").modifier(textModifier(fontSize: 8, fontWeight: .heavy, statColor: deltaColor ?? Color.blackPearl)).padding(.leading,5)
                }
                Spacer()
                Text(text).modifier(textModifier(fontSize: 10, fontWeight: .semibold, statColor: Color.blackPearl)).padding(.trailing,5)
            }
            if color == Color.lightgray{
                Text(text).modifier(textModifier(fontSize: 10, fontWeight: .semibold, statColor: Color.blackPearl)).padding(.leading,5)
                Spacer()
            }
            
        }.padding(.vertical,5).background(color).cornerRadius(5)
    }
}

struct stateStats: View {
    var stateWiseReportArray : [StateWiseReport]
    var stateWiseDistrictArray : [StateDetails]
    var seeAllbuttonClicked : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            ForEach(2..<stateWiseReportArray.count) { index in
                if self.seeAllbuttonClicked {
                    stateDetails(stateDetail: self.stateWiseReportArray[index],districtDetails: self.getstateDistricts(stateCode: self.stateWiseReportArray[index].stateCode))
                } else {
                    if index < 7{
                        stateDetails(stateDetail: self.stateWiseReportArray[index],districtDetails: self.getstateDistricts(stateCode: self.stateWiseReportArray[index].stateCode))
                    }
                }
                
            }
        }
    }
    
    func getstateDistricts(stateCode : String) -> [District]{
        var districtData : [District] = []
        for state in stateWiseDistrictArray {
            if state.statecode == stateCode {
                districtData = state.districtData
            }
        }
        return districtData
    }
}

struct stateDetails: View {
    var stateDetail : StateWiseReport
    var districtDetails : [District]
    @State var navigate : Bool = false
    var body : some View {
        HStack(alignment: .center, spacing: 5) {
            Button(action : {
                self.navigate = true
            }){
                HStack(alignment: .center){
                    Text(stateDetail.stateName).modifier(textModifier(fontSize: 10, fontWeight: .semibold, statColor: Color.blackPearl)).padding(.leading,5)
                    NavigationLink(destination: DistrictStatsView(stateDetail: stateDetail,districtDetails: districtDetails).navigationBarTitle("", displayMode: .inline).navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $navigate) {
                        Text("")
                    }
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width/(25/5) - 8).padding(.vertical,5).background(Color.pearlBlue).cornerRadius(5)
            }
            headerText(text: stateDetail.confirmed,color: Color.pearlBlue,deltaColor: Color.red,deltaStat: stateDetail.deltaConfirmed)
            headerText(text: stateDetail.active,color: Color.pearlBlue,deltaColor: nil,deltaStat: "0")
            headerText(text: stateDetail.recovered,color: Color.pearlBlue,deltaColor: Color.green,deltaStat: stateDetail.deltaRecovered)
            headerText(text: stateDetail.deaths,color: Color.pearlBlue,deltaColor: Color.black,deltaStat: stateDetail.deltaDeaths)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
