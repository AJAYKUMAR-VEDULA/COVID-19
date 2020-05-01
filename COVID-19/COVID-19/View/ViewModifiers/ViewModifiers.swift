//
//  ViewModifiers.swift
//  COVID-19
//
//  Created by AJ on 30/04/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import SwiftUI

struct textModifier: ViewModifier {
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    var statColor: Color
    func body(content: Content) -> some View {
        return content
            .font(.system(size: fontSize,weight: fontWeight, design: .default))
            .foregroundColor(statColor)
    }
}

struct statsBorderModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .frame(width: UIScreen.main.bounds.width/4 - 10, height: 100)
            .background(Color.white)
            .cornerRadius(10)
    }
}
