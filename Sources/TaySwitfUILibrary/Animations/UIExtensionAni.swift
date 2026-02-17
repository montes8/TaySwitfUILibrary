//
//  UIExtensionAni.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public extension View {
    func animBottomToTopView(isRevealed: Bool, y: CGFloat = 300) -> some View {
        self.offset(y: isRevealed ? 0 : y)
    }
    
    func animBottomToTop(isRevealed: Bool, y: CGFloat = 700) -> some View {
        self.offset(y: isRevealed ? 0 : y)
    }
    
    func animEndBottomToCenterTop(isRevealed: Bool,xFinal: CGFloat = 1.0,
                                  yFinal: CGFloat = 1.8,x: CGFloat = 0,
                                  y: CGFloat = 100) -> some View {
        self .scaleEffect(isRevealed ? xFinal : yFinal)
            .offset(x: isRevealed ? x : y)
    }
    
    func aniTransitionBottomToTop(colorCtn : Color = Color.uiBlack) -> some View {
        self.modifier(TransitionBottomToTop(colorCtn: colorCtn))
    }
    
    func bounceEffect(trigger: Bool) -> some View {
        self.offset(y: trigger ? -15 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.4), value: trigger)
    }
    
    func fromBottomToTop(positionY : CGFloat = 65.0,duration : CGFloat = 1.5,fraction : CGFloat = 0.7) -> some View {
        self.modifier(RevealAnimationModifier(positionY:positionY,duration:duration,fraction:fraction))
    }
}


struct TransitionBottomToTop: ViewModifier {
    @State private var internalRevealed: Bool = false
    var colorCtn : Color = Color.uiBlack
    func body(content: Content) -> some View {
        ZStack {
            colorCtn
                .ignoresSafeArea()
            
            content
                .environment(\EnvironmentValues.isRevealed, internalRevealed)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 1.8, dampingFraction: 0.9)) {
                    internalRevealed = true
                }
            }
        }
    }
}

struct RevealAnimationModifier: ViewModifier {
    var positionY : CGFloat
    var duration : CGFloat
    var fraction : CGFloat
    @State private var internalRevealed = false
    
    func body(content: Content) -> some View {
        content
            .offset(y: internalRevealed ? 0 : positionY)
            .onAppear {
                withAnimation(.spring(response: duration, dampingFraction: fraction)) {
                    internalRevealed = true
                }
            }
    }
}


public struct IsRevealedKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}

extension EnvironmentValues {
    public var isRevealed: Bool {
        get { self[IsRevealedKey.self] }
        set { self[IsRevealedKey.self] = newValue }
    }
}
