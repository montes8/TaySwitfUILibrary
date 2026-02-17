//
//  Toast.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

struct ViewSizeKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

public struct Toast: ViewModifier {
    @Binding var isPresented: Bool
    var cmMessage: String = uiTest
    var cmWidth: CGFloat = 150
    var positionX: CGFloat = 0
    var positionXCustom: Bool = false
    var position : Alignment = .topTrailing
    var mVertical: CGFloat = 8
    var mHorizontal: CGFloat = 0
    var duration: TimeInterval = 3.0
    var cmToast: ToastModel? = ToastModel()
    @State private var parentSize: CGSize = .zero
    
    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: ViewSizeKey.self, value: geo.size)
                }
            )
            .onPreferenceChange(ViewSizeKey.self) { parentSize = $0 }
            .overlay(
                ZStack {
                    if isPresented{
                        VStack(spacing: 0) {
                            Triangle()
                                .fill(Color.uiBlue200)
                                .frame(width: 10, height: 8)
                                .offset(x: positionXCustom ? positionX : getPositionXArrow(position: position))
                            
                            Text(cmMessage)
                                .font(.uiMontM12)
                                .padding(6)
                                .background(Color.uiBlue200)
                                .foregroundColor(Color.uiBlue900)
                                .cornerRadius(8)
                                .frame(width: cmWidth)
                        }
                        .offset(x: mHorizontal, y: (parentSize.height + 15) + mVertical)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                        .onAppear {
                            if duration > 0 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                    withAnimation {isPresented = false}
                                }
                            }
                        }
                    }
                },
                alignment: position
            )
    }
    
    private func getPositionXArrow(position : Alignment)->CGFloat{
        switch (position){
        case .topLeading:
            return -((cmWidth/2) - 15)
        case .topTrailing:
            return (cmWidth/2)-15
        default:
            return 0
        }
    }
}


public struct ToastModel: Equatable {
    let message: String
    
    public init(message: String = uiEmpty) {
        self.message = message
    }
    
    public static func success(message: String) -> ToastModel {
        return ToastModel(message: message)
    }
    
}
