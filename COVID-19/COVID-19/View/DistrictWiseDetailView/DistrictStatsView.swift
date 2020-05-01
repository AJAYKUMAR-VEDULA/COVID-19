//
//  DistrictStatsView.swift
//  COVID-19
//
//  Created by AJ on 29/04/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import SwiftUI

struct DistrictStatsView: View {
    var stateDetail : StateWiseReport
    var districtDetails : [District]
    @State var buttonTitle : String = "Show Meter"
    @State var showMeter : Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10){
                HStack(alignment: .center){
                    Spacer()
                    Text(stateDetail.stateName).modifier(textModifier(fontSize: 18, fontWeight: .semibold, statColor: Color.blackPearl)).padding(10)
                    Spacer()
                }.background(Color.pearlBlue)
                HStack(alignment: .center){
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }){
                        Text("Back").padding(6).modifier(textModifier(fontSize: 12, fontWeight: .semibold, statColor: Color.blackPearl)).background(Color.lightgray).cornerRadius(5)
                    }
                    Spacer()
                    Button(action: {
                        self.showMeter.toggle()
                        if self.showMeter {
                            self.buttonTitle = "Show Stats"
                        } else {
                            self.buttonTitle = "Show Meter"
                        }
                    }){
                        Text(buttonTitle).padding(6).modifier(textModifier(fontSize: 12, fontWeight: .semibold, statColor: Color.blackPearl)).background(Color.lightgray).cornerRadius(5)
                        
                    }
                }.padding(.horizontal,10)
                if showMeter == true {
                    StatsMeter(stateDetail: stateDetail).padding(.horizontal,10)
                } else {
                    TotalStats(headerTitle: StateWiseReport(stateName: "", confirmed: "Confirmed", recovered: "Recovered", deaths: "Deceased", active: "Active", lastUpdatedTime: "", deltaConfirmed: "", deltaRecovered: "", deltaDeaths: "", stateCode: ""), totalStats: stateDetail)
                }
                DistrictWiseReport(districtDetails: districtDetails).padding(.horizontal,10)
                Spacer()
            }
        }
    }
}

struct DistrictWiseReport : View {
    var districtDetails : [District]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("District Wise Report").modifier(textModifier(fontSize: 12, fontWeight: .semibold, statColor: Color.deepBlue))
            stateHeader(headerTitle: StateWiseReport(stateName: "District", confirmed: "Confirmed", recovered: "Recovered", deaths: "Deceased", active: "Active", lastUpdatedTime: "", deltaConfirmed: "", deltaRecovered: "", deltaDeaths: "", stateCode: ""))
            districtStats(districtWiseReportArray: districtDetails)
        }
    }
}

struct districtStats: View {
    var districtWiseReportArray : [District]
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            ForEach(0..<districtWiseReportArray.count) { index in
                districtDetails(districtDetail: self.districtWiseReportArray[index])
                }
            }
        }
    }


struct districtDetails: View {
    var districtDetail : District
    var body : some View {
        HStack(alignment: .center, spacing: 5) {
            Button(action : {
                
            }){
                HStack(alignment: .center){
                    Text(districtDetail.district).modifier(textModifier(fontSize: 10, fontWeight: .semibold, statColor: Color.blackPearl)).padding(.leading,5)
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width/(25/5) - 8).padding(.vertical,5).background(Color.pearlBlue).cornerRadius(5)
            }
            headerText(text: "\(districtDetail.confirmed)",color: Color.pearlBlue,deltaColor: Color.red,deltaStat: "\(districtDetail.delta.confirmed)")
            headerText(text: "\(districtDetail.active)",color: Color.pearlBlue,deltaColor: nil,deltaStat: "0")
            headerText(text: "\(districtDetail.recovered)",color: Color.pearlBlue,deltaColor: Color.green,deltaStat: "\(districtDetail.delta.recovered)")
            headerText(text: "\(districtDetail.deceased)",color: Color.pearlBlue,deltaColor: Color.black,deltaStat: "\(districtDetail.delta.deceased)")
        }
    }
}







