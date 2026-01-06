//
//  StaggerContainer.swift
//  FunnyAnimation
//
//  Created by OLEKSANDR ISAIEV on 06.01.2026.
//

import SwiftUI

struct StaggerContainer: ViewModifier {
    @State private var remainingPayloads: [StaggerKey.Payload] = []
    @State private var seen: Set<Namespace.ID> = []

    var delays: [Namespace.ID: Double] {
        let sorted = remainingPayloads.sorted(by: { l, r in
            if l.priority > r.priority { return true }
            if l.priority < r.priority { return false }
            let lDist = l.frameInGlobal.minX * l.frameInGlobal.minX + l.frameInGlobal.minY * l.frameInGlobal.minY
            let rDist = r.frameInGlobal.minX * r.frameInGlobal.minX + r.frameInGlobal.minY * r.frameInGlobal.minY
            return lDist < rDist
        })
        return Dictionary(uniqueKeysWithValues: sorted.enumerated().map { (ix, payload) in
            (payload.id, Double(ix) * 0.1)
        })
    }

    func body(content: Content) -> some View {
        content
            .environment(\.delays, delays)
            .onPreferenceChange(StaggerKey.self) { payloads in
                self.remainingPayloads = payloads.filter { !seen.contains($0.id) }
                seen.formUnion(self.remainingPayloads.map(\.id))
        }
    }
}

extension View {
    func staggerContainer() -> some View {
        modifier(StaggerContainer())
    }
}
