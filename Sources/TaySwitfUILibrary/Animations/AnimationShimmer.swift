//
//  AnimationShimmer.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

struct AnimationShimmer: ViewModifier {
    var cornerRadius: CGFloat
    @State private var phase: CGFloat = -1.5

    func body(content: Content) -> some View {
        content
            .opacity(0)
            .overlay(
                GeometryReader { geo in
                    let width = geo.size.width
                    let height = geo.size.height
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color(white: 0.9))
                            .padding(-4)
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .clear, location: 0.2),
                                .init(color: .uiGrey300.opacity(0.6), location: 0.5),
                                .init(color: .clear, location: 0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .scaleEffect(x: 3)
                        .offset(x: (width + 8) * phase)
                    }
                    .frame(width: width, height: height)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1.5
                }
            }
    }
}
