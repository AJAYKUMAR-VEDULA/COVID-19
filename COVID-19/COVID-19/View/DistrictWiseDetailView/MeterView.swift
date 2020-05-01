//
//  MeterView.swift
//  COVID-19
//
//  Created by AJ on 30/04/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import SwiftUI


struct StatsMeter : View {
    let activeColor = [Color.blue, Color.blue]
    let recoveredColor = [Color.green,Color.green]
    let deathColor = [Color.black, Color.black]
    var stateDetail : StateWiseReport
    var body: some View {
        VStack(){
            HStack(alignment: .center ){
                MeterDetails(meterText: "Active", color: activeColor, progress: stateDetail.active, total: stateDetail.confirmed)
                Spacer()
                MeterDetails(meterText: "Recovered", color: recoveredColor, progress: stateDetail.recovered, total: stateDetail.confirmed)
                Spacer()
                 MeterDetails(meterText: "Deceased", color: deathColor, progress: stateDetail.deaths, total: stateDetail.confirmed)
            }
            MeterLegends(stateDetail: stateDetail)
        }.padding(.horizontal,10).padding(.top,10).cornerRadius(10).shadow(radius: 10)
    }
}

struct MeterDetails: View {
    var meterText : String
    var color : [Color]
    var progress : String
    var total : String
    var body: some View {
        VStack(spacing: 10){
            Text(meterText).modifier(textModifier(fontSize: 12, fontWeight: .semibold, statColor: color[0]))
            Meter(secondaryColor: color, progress: CGFloat(truncating: NumberFormatter().number(from: progress)!), total: CGFloat(truncating: NumberFormatter().number(from: total)!))
        }
    }
}

struct Meter: View {
    let Colors = [Color.blue, Color.silver]
    var secondaryColor : [Color]
    var progress : CGFloat
    var total: CGFloat
    var body: some View {
        ZStack{
            ZStack{
                Circle().trim(from: 0, to: 0.5).stroke(AngularGradient(gradient: .init(colors: self.getPrimaryColor()), center: .center, angle: .init(degrees: 180)), lineWidth: 20).frame(width: UIScreen.main.bounds.width/4,height: UIScreen.main.bounds.width/3)
                Circle().trim(from: 0, to: self.setProgress(progress: progress)).stroke(AngularGradient(gradient: .init(colors: self.secondaryColor), center: .center, angle: .init(degrees: 180)), lineWidth: 20).frame(width: UIScreen.main.bounds.width/4,height: UIScreen.main.bounds.width/3)
            }.rotationEffect(.init(degrees: 180))
            ZStack(alignment: .bottom) {
                self.Colors[1].frame(width: 2, height: 74)
                Circle().fill(self.Colors[1]).frame(width: 15, height: 15)
            }.offset(y: -25).rotationEffect(.init(degrees: -90)).rotationEffect(.init(degrees: self.setArrow(progress: progress)))
        }
    }
    func getPrimaryColor() -> [Color] {
        if total != 0 {
            return [Color.red,Color.red]
        } else {
            return [Color.lightgray, Color.lightgray]
        }
    }
    func setProgress(progress: CGFloat) -> CGFloat {
        if total != 0 && progress <= total {
            let temp = progress/(2*total)
            return  temp
        } else {
            return 0
        }
    }
    func setArrow(progress: CGFloat)->Double{
        if total != 0 && progress <= total {
            let temp = progress / total
            return Double(temp*180)
        }else {
            return 0
        }
    }
}

struct MeterLegends: View {
    var stateDetail : StateWiseReport
    var body: some View {
        HStack(alignment: .center) {
            Legend(value: "\(stateDetail.confirmed)", color: Color.red)
            Spacer()
            Legend(value: "\(stateDetail.active)", color: Color.blue)
            Spacer()
            Legend(value: "\(stateDetail.recovered)", color: Color.green)
            Spacer()
            Legend(value: "\(stateDetail.deaths)", color: Color.black)
        }.padding(.top,-50)
    }
}

struct Legend : View {
    var value : String
    var color: Color
    var body: some View {
        HStack(spacing: 5){
            VStack(){
                Text("")
            }.frame(width: 7, height: 7).background(color)
            Text(value).modifier(textModifier(fontSize: 12, fontWeight: .semibold, statColor: Color.black))
        }
    }
}
