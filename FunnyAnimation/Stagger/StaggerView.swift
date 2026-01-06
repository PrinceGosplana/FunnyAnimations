//
//  StaggerView.swift
//  FunnyAnimation
//
//  Created by OLEKSANDR ISAIEV on 06.01.2026.
//

import SwiftUI

struct StaggerView: View {
    @State var colors = MyColor.sampleColors
    
    private var rect: RoundedRectangle {
        RoundedRectangle(cornerRadius: 16)
    }
    
    var body: some View {

        VStack(spacing: 16) {
            
            rect.fill(.blue.gradient)
                .frame(height: 120)
                .stagger(transition: .move(edge: .top).combined(with: .opacity), priority: -1)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [.init(.adaptive(minimum: 80), spacing: 16)], spacing: 16) {
                    ForEach(colors) { color in
                        rect.fill(color.color.gradient)
                            .frame(height: 80)
                            .stagger(transition: .scale)
                    }
                }
            }
            Button("Add") {
                for _ in 0..<5 {
                    colors.append(.init(color: Color(hue: .random(in: 0...1), saturation: 0.6, brightness: 0.6)))
                }
            }
        }
        .padding()
        .staggerContainer()
    }
}

#Preview {
    StaggerView()
}
