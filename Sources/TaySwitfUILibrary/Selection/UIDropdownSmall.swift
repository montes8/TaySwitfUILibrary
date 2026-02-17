//
//  UIDropdownSmall.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct UIDropdownSmall: View {
    let options: [DropdownItemSmall]
    @Binding var selection: DropdownItemSmall
    @State private var isExpanded: Bool = false
    var styleModel : DropSmallModel = DropSmallModel()
    let action: (DropdownItemSmall) -> Void
    
    public init(options: [DropdownItemSmall], selection: Binding<DropdownItemSmall>, styleModel: DropSmallModel = IniTaySwitUI.styleDropdownSmall,
                action: @escaping (DropdownItemSmall) -> Void = { _ in }) {
        self.options = options
        self._selection = selection
        self._isExpanded = State(initialValue: false)
        self.styleModel = styleModel
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            withAnimation(.snappy) {
                if(!options.isEmpty){
                    isExpanded.toggle()
                }
            }
        }) {
            HStack(spacing: 4) {
                Image(uiName: styleModel.iconStart)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: styleModel.sizeIcon,height: styleModel.sizeIcon)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .foregroundColor(selection.value.isEmpty ? styleModel.textColorActive: styleModel.textColor)
                
                Text(selection.value.isEmpty ? styleModel.placeHolder : selection.value)
                    .font(styleModel.textFont)
                    .foregroundColor(selection.value.isEmpty ? styleModel.textColorActive :styleModel.textColor)
            }.drawingGroup()
                .padding(.horizontal, styleModel.mHorizontal)
                .padding(.vertical, styleModel.mVertical)
                .background(styleModel.bgColor)
                .cornerRadius(styleModel.radius)
        }
        .overlay(alignment: .topLeading) {
            if isExpanded {
                dropdownList
                    .fixedSize()
                    .offset(y: 20 + styleModel.mTopList)
                    .zIndex(500)
            }
        }
    }
    
    private var dropdownList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(options, id: \.uiId) { option in
                Button(action: {
                    selection = option
                    withAnimation {
                        isExpanded = false
                        action(option)
                    }
                }) {
                    Text(option.value)
                        .font(styleModel.textFontItem)
                        .foregroundColor(selection.value == option.value ? styleModel.textItemColor :styleModel.textItemColorActive)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 20)
                        .background(selection.value == option.value ? Color.clear : styleModel.bgColorItemSelected )
                }
            }
        }
        .padding(.vertical, 6)
        .frame(minWidth: styleModel.widthList)
        .background(styleModel.bgColorList)
        .overlay(
            RoundedRectangle(cornerRadius: styleModel.radiusList)
                .stroke(styleModel.bgBorderColorList)
        )
        .cornerRadius(styleModel.radiusList)
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        .fixedSize()
        .transition(.asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 0.9, anchor: .topLeading)),
            removal: .opacity
        ))
    }
}

public struct DropSmallModel {
    public var iconStart: String
    public var placeHolder: String
    public var textColor: Color
    public var textColorActive: Color
    public var textItemColor: Color
    public var textItemColorActive: Color
    public var bgColor: Color
    public var bgColorList: Color
    public var bgColorItemSelected: Color
    public var bgBorderColor: Color
    public var bgBorderColorList: Color
    public var radius: CGFloat
    public var radiusList: CGFloat
    public var sizeIcon: CGFloat
    public var mTopList: CGFloat
    public var mHorizontal: CGFloat
    public var mVertical: CGFloat
    public var textFont: Font
    public var textFontItem: Font
    public var widthList: CGFloat
    
    init(
        iconStart: String = "ic_cm_arrow_down",
        placeHolder: String = uiEmpty,
        textColor: Color = Color.uiBlack,
        textColorActive: Color = Color.uiBlack,
        textItemColor: Color = Color.uiBlack,
        textItemColorActive: Color = Color.uiGrey800,
        bgColor: Color = Color.white,
        bgColorList: Color = Color.white,
        bgColorItemSelected : Color = Color.white,
        bgBorderColor: Color = Color.white,
        bgBorderColorList: Color = Color.uiGrey400,
        radius: CGFloat = 6,
        radiusList: CGFloat = 6,
        sizeIcon: CGFloat = 14,
        mTopList:CGFloat = 10,
        mHorizontal: CGFloat = 10,
        mVertical: CGFloat = 6,
        textFont: Font = Font.uiMontM10,
        textFontItem: Font = Font.uiMontM12,
        widthList : CGFloat =  107) {
            self.iconStart = iconStart
            self.placeHolder = placeHolder
            self.textColor = textColor
            self.textColorActive = textColorActive
            self.textItemColor = textItemColor
            self.textItemColorActive = textItemColorActive
            self.bgColor = bgColor
            self.bgColorList = bgColorList
            self.bgColorItemSelected = bgColorItemSelected
            self.bgBorderColor = bgBorderColor
            self.bgBorderColorList = bgBorderColorList
            self.radius = radius
            self.radiusList = radiusList
            self.sizeIcon = sizeIcon
            self.mTopList = mTopList
            self.mHorizontal = mHorizontal
            self.mVertical = mVertical
            self.textFont = textFont
            self.textFontItem = textFontItem
            self.widthList = widthList
        }
    
}


public struct DropdownItemSmall : Codable{
    public var uiId: String
    public var uiIdAlter: String
    public var value: String
    
    public init(uiId: String = "0", uiIdAlter: String = "es", value: String = "Español") {
        self.uiId = uiId
        self.uiIdAlter = uiIdAlter
        self.value = value
    }
}
