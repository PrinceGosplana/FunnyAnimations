//
//  MyColors.swift
//  FunnyAnimation
//
//  Created by OLEKSANDR ISAIEV on 06.01.2026.
//

import SwiftUI

struct MyColor: Identifiable {
    var id = UUID()
    var color: Color
}

extension MyColor {
    static let sampleColors = (0..<10).map { ix in
        MyColor(color: .init(hue: .init(ix) / 20, saturation: 0.8, brightness: 0.8))
    }
}
