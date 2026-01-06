//
//  StaggerKey.swift
//  FunnyAnimation
//
//  Created by OLEKSANDR ISAIEV on 06.01.2026.
//

import SwiftUI

struct StaggerKey: PreferenceKey {
    struct Payload: Hashable {
        var id: Namespace.ID
        var priority: Double
        var frameInGlobal: CGRect
    }
    static let defaultValue: [Payload] = []
    static func reduce(value: inout [Payload], nextValue: () -> [Payload]) {
        value.append(contentsOf: nextValue())
    }
}
