//
//  UIItemView.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct UIItemView: View {
    
    var titleItem: String
    var iconItem: String
    var iconSize: CGFloat
    var textColor: Color
    var textFont: Font
    var paddingV: CGFloat
    var paddingH: CGFloat
    var iRadius: CGFloat
    var iShadow: Bool
    var uiBackground: Color
    var actionItem: () -> Void = { }
    
    public init(titleItem: String = "Tayler zeref",
                iconItem: String = "ic_configuration",
                iconSize: CGFloat = 50,
                textColor: Color = .uiGrey800,
                textFont: Font = Font.uiMontM12,
                paddingV: CGFloat = 12,
                paddingH: CGFloat = 12,
                iRadius: CGFloat = 8,
                iShadow : Bool = false,
                uiBackground: Color = .white,
                actionItem: @escaping () -> Void = { }) {
        self.titleItem = titleItem
        self.iconItem = iconItem
        self.iconSize = iconSize
        self.textColor = textColor
        self.textFont = textFont
        self.paddingV = paddingV
        self.paddingH = paddingH
        self.iRadius = iRadius
        self.iShadow = iShadow
        self.uiBackground = uiBackground
        self.actionItem = actionItem
    }
    
    public var body: some View {
        VStack() {
            VStack(spacing : 4){
                Image(cmName:iconItem).resizable().frame(width: iconSize.cmSizeView(),height: iconSize.cmSizeView())
                Text(titleItem).foregroundColor(textColor).font(textFont)
                    .multilineTextAlignment(.center)
            }.padding(.horizontal,paddingH).padding(.vertical,paddingV).onTapGesture {
                actionItem()
            }
        }.drawingGroup().background(
            RoundedRectangle(cornerRadius: iRadius)
                .fill(cmBackground)
                .shadow(color: Color.black.opacity(iShadow ? 0.12 : 0), radius: iShadow ? 20 : 0, x: 0, y: iShadow ? 12 :0)
                .shadow(color: Color.black.opacity(iShadow ? 0.08 :0), radius: iRadius, x: 0, y: iShadow ? 4 : 0)
            
        )
    }
    
}
