//
//  Stagger.swift
//  FunnyAnimation
//
//  Created by OLEKSANDR ISAIEV on 06.01.2026.
//

import SwiftUI

struct Stagger<T: Transition>: ViewModifier {
    var transition: T
    var priority: Double
    @Namespace var namespace
    @Environment(\.delays) var delays
    @State private var visible = false
    
    func body(content: Content) -> some View {
        transition.apply(content: content, phase: visible ? .identity : .willAppear)
            .overlay {
                if let d = delays[namespace] {
                    Text("\(d, format: .number.precision(.fractionLength(2)))")
                }
            }
            .overlay {
                GeometryReader  { proxy in
                    let frame = proxy.frame(in: .global)
                    Color.clear
                        .preference(key: StaggerKey.self, value: [.init(id: namespace, priority: priority, frameInGlobal: frame)])
                    
                }
            }
            .onChange(of: delays[namespace]) { _, delay in
                guard let delay else { return }
                withAnimation(.default.delay(delay)) {
                    visible = true
                }
            }
    }
}

extension View {
    func stagger(priority: Double = 0) -> some View {
        modifier(Stagger(transition: .opacity, priority: priority))
    }

    func stagger<T: Transition>(transition: T, priority: Double = 0) -> some View {
        modifier(Stagger(transition: transition, priority: priority))
    }
}
