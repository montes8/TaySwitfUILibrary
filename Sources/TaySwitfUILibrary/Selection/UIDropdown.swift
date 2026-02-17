//
//  UIDropdown.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct UIDropdown: View {
    @Environment(\.isEnabled) private var isEnabled
    let title: String
    let placeholder: String
    let options: [DropdownItem]
    @Binding var selectedOption: DropdownItem
    var styleLight : Bool = true
    var model : DropdownModel
    var styleConfig : DropdownConfig = DropdownConfig()
    let actionItem: (DropdownItem) -> Void
    @State private var isOpen: Bool = false
    
    
    public init(title: String,
                placeholder: String,
                options: [DropdownItem],
                selectedOption: Binding<DropdownItem>,
                styleLight : Bool = true,
                model: DropdownModel = DropdownModel(),
                styleConfig : DropdownConfig = IniTaySwitUI.styleDropdown,
                actionItem: @escaping (DropdownItem) -> Void = { _ in }
                
    ) {
        self.title = title
        self.placeholder = placeholder
        self.options = options
        self._selectedOption = selectedOption
        self.model = model
        self.styleConfig = styleConfig
        self.styleLight = styleLight
        self.actionItem = actionItem
    }
    
    private var colorTextTitle: Color {
        return styleLight ? colorTextTitleValid : colorTextTitleValidDark
    }
    
    private var colorTextTitleValid: Color {
        return !isEnabled ? styleConfig.titleColorDisable : styleConfig.titleColor
    }
    
    private var colorTextTitleValidDark: Color {
        return !isEnabled ? styleConfig.titleColorDisableDark : styleConfig.titleColorDark
    }
    
    private var colorTextTitleActive: Color {
        return styleLight ? styleConfig.titleColorActive : styleConfig.titleColorActiveDark
    }
    
    private var colorText: Color {
        return styleLight ? colorTextValid : colorTextValidDark
    }
    
    private var colorTextValid: Color {
        return !isEnabled ? styleConfig.textColorDisable : styleConfig.textColor
    }
    
    private var colorTextValidDark: Color {
        return !isEnabled ? styleConfig.textColorDarkDisable : styleConfig.textColorDark
    }
    
    private var colorTextActive: Color {
        return styleLight ? styleConfig.titleColorActive : styleConfig.titleColorActiveDark
    }
    
    private var bgColor: Color {
        return styleLight ? bgColorValid : bgColorValidDark
    }
    
    private var bgColorValid: Color {
        return !isEnabled ? styleConfig.bgColorDisable : styleConfig.bgColor
    }
    
    private var bgColorValidDark: Color {
        return !isEnabled ? styleConfig.bgColorDisableDark : styleConfig.bgColorDark
    }
    
    private var bgColortActive: Color {
        return styleLight ? styleConfig.bgColorActive : styleConfig.bgColorActiveDark
    }
    
    private var borderColor: Color {
        return styleLight ? borderValid : borderValidDark
    }
    
    private var borderValid: Color {
        return !isEnabled ? styleConfig.borderColorDisable : styleConfig.borderColor
    }
    
    private var borderValidDark: Color {
        return !isEnabled ? styleConfig.borderColorDisableDark : styleConfig.borderColorDark
    }
    
    
    private var borderColortActive: Color {
        return styleLight ? styleConfig.borderColorActive : styleConfig.borderColorActiveDark
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(styleConfig.titleFont)
                .foregroundColor(isOpen ? colorTextTitleActive :colorTextTitle)
            
            HStack(spacing:8) {
                if(!model.iconStart.wrappedValue.isEmpty){
                    Image(uiName: model.iconStart.wrappedValue)
                }
                
                Text(selectedOption.value.isEmpty ? placeholder : selectedOption.value)
                    .font(styleConfig.textFont)
                    .foregroundColor(isOpen ? colorTextActive :colorText)
                Spacer()
                Image(uiName: model.iconEnd).renderingMode(.template)
                    .foregroundColor( isOpen ? colorTextActive : colorText)
                    .rotationEffect(.degrees(isOpen ? 180 : 0))
                
            }
            .padding(.horizontal, styleConfig.paddingHorizontal)
            .padding(.vertical, styleConfig.paddingVertical)
            .background(isOpen ? bgColortActive : bgColor)
            .overlay(
                RoundedRectangle(cornerRadius: styleConfig.uiRadius)
                    .stroke(isOpen ? borderColortActive :borderColor, lineWidth: 1.5)
            ).cornerRadius(styleConfig.uiRadius).onTapGesture {
                if(isEnabled){
                    isOpen.toggle()
                }
                
            }.overlay(
                VStack {
                    if isOpen {
                        dropdownList
                            .offset(y: 40 + styleConfig.marginTopList)
                    }
                },
                alignment: .top
            )
            .zIndex(100)
            
        }
    }
    
    private var colorTextItem: Color {
        return styleLight ? styleConfig.textItemColor : styleConfig.textItemColorDark
    }
    
    private var colorTextItemActive: Color {
        return styleLight ? styleConfig.textItemColorActive : styleConfig.textItemColorActiveDark
    }
    
    private var bgColorList: Color {
        return styleLight ? styleConfig.bgColorList : styleConfig.bgColorDarkList
    }
    
    private var bgColorItem: Color {
        return styleLight ? styleConfig.bgColorItemList : styleConfig.bgColorItemDarkList
    }
    
    private var bgColorItemActive: Color {
        return styleLight ? styleConfig.bgColorItemListActive : styleConfig.bgColorItemDarkListActive
    }
    
    
    
    private func dropdownItem(_ option: DropdownItem) -> some View {
        Button(action: {
            selectedOption = option
            isOpen = false
        }) {
            HStack {
                Text(option.value)
                    .font(isOpen ? styleConfig.textFontItemActive:styleConfig.textFontItem)
                    .foregroundColor(selectedOption.value == option.value ? colorTextItemActive : colorTextItem)
                Spacer()
                if(model.styleDual){
                    HStack {
                        Spacer()
                        Text(option.valueAlter)
                            .font(.uiMontM16)
                            .foregroundColor(selectedOption.value == option.value ? colorTextItemActive : colorTextItem)
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 40)
            .background(selectedOption.value == option.value ? bgColorItemActive : bgColorItem)
        }
    }
    
    @State private var scrollOffset: CGFloat = 0
    
    
    private var dropdownList: some View {
        let visibleHeight: CGFloat = 176
        let itemHeight: CGFloat = 40
        let totalContentHeight: CGFloat = CGFloat(options.count) * itemHeight + 16
        
        return ZStack(alignment: .topTrailing) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    GeometryReader { geo in
                        Color.clear.preference(
                            key: ScrollOffsetKey.self,
                            value: geo.frame(in: .named("scrollContainer")).minY
                        )
                    }
                    .frame(height: 0)
                    
                    Spacer().frame(height: 8)
                    
                    ForEach(options, id: \.self) { option in
                        dropdownItem(option)
                    }
                    
                    Spacer().frame(height: 8)
                }
            }
            .coordinateSpace(name: "scrollContainer")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                self.scrollOffset = -value
            }
            .frame(height: visibleHeight)
            
            if totalContentHeight > visibleHeight {
                let scrollRange = totalContentHeight - visibleHeight
                let progress = max(0, min(1, scrollOffset / scrollRange))
                
                let indicatorHeight: CGFloat = 40
                let maxTravel = visibleHeight - indicatorHeight - 16
                
                Capsule()
                    .fill(indicatorColor)
                    .frame(width: 6, height: indicatorHeight)
                    .padding(.trailing, 6)
                    .padding(.top, 8)
                    .offset(y: progress * maxTravel)
            }
        }
        .background(bgColorList)
        .overlay(
            RoundedRectangle(cornerRadius: styleConfig.uiRadiusList)
                .stroke(borderColorList, lineWidth: 1.5)
        )
        .cornerRadius(styleConfig.uiRadiusList)
        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        
    }
    
    private var indicatorColor: Color {
        return styleLight ? styleConfig.colorIndicator : styleConfig.colorIndicatorDark
    }
    
    private var borderColorList: Color {
        return styleLight ? styleConfig.borderColorList : styleConfig.borderColorDarkList
    }
    
}

struct ScrollOffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


public struct DropdownModel {
    public var iconStart: Binding<String>
    public var iconEnd: String
    public var styleDual: Bool
    
    public init(
        iconStart: Binding<String> = .constant(uiEmpty),
        iconEnd: String = "ic_cm_arrow_down",
        styleDual: Bool = false
    ) {
        self.iconStart = iconStart
        self.iconEnd = iconEnd
        self.styleDual = styleDual
    }
}

public struct DropdownItem :Hashable{
    public var uiId: String
    public var uiIdAlter: String
    public var value: String
    public var valueAlter: String
    
    public init(
        uiId: String = uiEmpty,
        uiIdAlter: String = uiEmpty,
        value: String = uiEmpty,
        valueAlter: String = uiEmpty
    ) {
        self.uiId = uiId
        self.uiIdAlter = uiIdAlter
        self.value = value
        self.valueAlter = valueAlter
    }
    
}


public struct DropdownConfig {
    var titleColor: Color
    var titleColorDark: Color
    var titleColorDisable: Color
    var titleColorDisableDark: Color
    var titleColorActive: Color
    var titleColorActiveDark: Color
    var textColor: Color
    var textColorDark: Color
    var textColorDisable: Color
    var textColorDarkDisable: Color
    var textColorActive: Color
    var textColorActiveDark: Color
    var borderColor: Color
    var borderColorDark: Color
    var borderColorDisable: Color
    var borderColorDisableDark: Color
    var bgColorDisable: Color
    var bgColorDisableDark: Color
    var borderColorActive: Color
    var borderColorActiveDark: Color
    var bgColor: Color
    var bgColorDark: Color
    var bgColorActive: Color
    var bgColorActiveDark: Color
    var textItemColor: Color
    var textItemColorDark: Color
    var textItemColorActive: Color
    var textItemColorActiveDark: Color
    var bgColorList: Color
    var bgColorDarkList: Color
    var borderColorList: Color
    var borderColorDarkList: Color
    var bgColorItemList: Color
    var bgColorItemDarkList: Color
    var bgColorItemListActive: Color
    var bgColorItemDarkListActive: Color
    var textColorLits: Color
    var textColorDarkList: Color
    var textColorLitsActive: Color
    var textColorDarkListActive: Color
    var colorIndicator: Color
    var colorIndicatorDark: Color
    var titleFont: Font
    var textFont: Font
    var textFontItem: Font
    var textFontItemActive: Font
    var uiRadius: CGFloat
    var uiRadiusList: CGFloat
    var marginTopList: CGFloat
    var paddingVertical: CGFloat
    var paddingHorizontal: CGFloat
    
    public init(
        titleColor: Color = .uiGrey800,
        titleColorDark: Color = .uiGrey800,
        titleColorDisable: Color = .uiGrey400,
        titleColorDisableDark: Color = .uiGrey400,
        titleColorActive: Color = .uiBlack,
        titleColorActiveDark: Color = .uiBlack,
        textColor: Color = .uiGrey800,
        textColorDark: Color = .uiGrey800,
        textColorDisable: Color = .uiGrey400,
        textColorDarkDisable: Color = .uiGrey400,
        textColorActive: Color = .uiBlack,
        textColorActiveDark: Color = .uiBlack,
        borderColor: Color = .uiGrey800,
        borderColorDark: Color = .uiGrey800,
        borderColorDisable: Color = Color.uiGrey400,
        borderColorDisableDark: Color = Color.uiGrey400,
        bgColorDisable: Color = Color.white,
        bgColorDisableDark: Color = Color.white,
        borderColorActive: Color = .uiBlack,
        borderColorActiveDark: Color = .uiBlack,
        bgColor: Color = .white,
        bgColorDark: Color = .white,
        bgColorActive: Color = .white,
        bgColorActiveDark: Color = .white,
        textItemColor: Color = .uiGrey800,
        textItemColorDark: Color = .uiGrey800,
        textItemColorActive: Color = .uiGrey800,
        textItemColorActiveDark: Color = .uiGrey800,
        bgColorList: Color = .white,
        bgColorDarkList: Color = .white,
        borderColorList: Color = .uiGrey200,
        borderColorDarkList: Color = .uiGrey200,
        bgColorItemList: Color = .white,
        bgColorItemDarkList: Color = .white,
        bgColorItemListActive: Color = .uiGrey200,
        bgColorItemDarkListActive: Color = .uiGrey200,
        textColorLits: Color = .uiGrey800,
        textColorDarkList: Color = .uiGrey800,
        textColorLitsActive: Color = .uiBlack,
        textColorDarkListActive: Color = .uiBlack,
        colorIndicator: Color = Color.uiGrey200,
        colorIndicatorDark: Color = Color.uiGrey400,
        titleFont: Font = .uiMontM14,
        textFont: Font = .uiMontM14,
        textFontItem: Font = .uiMontM16,
        textFontItemActive: Font = .uiMontM16,
        uiRadius: CGFloat = 28,
        uiRadiusList: CGFloat = 20,
        marginTopList: CGFloat = 20,
        paddingVertical: CGFloat = 10,
        paddingHorizontal: CGFloat = 20
    ) {
        self.titleColor = titleColor
        self.titleColorDark = titleColorDark
        self.titleColorDisable = titleColorDisable
        self.titleColorDisableDark = titleColorDisableDark
        self.titleColorActive = titleColorActive
        self.titleColorActiveDark = titleColorActiveDark
        self.textColor = textColor
        self.textColorDark = textColorDark
        self.textColorDisable = textColorDisable
        self.textColorDarkDisable = textColorDarkDisable
        self.textColorActive = textColorActive
        self.textColorActiveDark = textColorActiveDark
        self.borderColor = borderColor
        self.borderColorDark = borderColorDark
        self.borderColorDisable = borderColorDisable
        self.borderColorDisableDark = borderColorDisableDark
        self.bgColorDisable = bgColorDisable
        self.bgColorDisableDark = bgColorDisableDark
        self.borderColorActive = borderColorActive
        self.borderColorActiveDark = borderColorActiveDark
        self.bgColor = bgColor
        self.bgColorDark = bgColorDark
        self.bgColorActive = bgColorActive
        self.bgColorActiveDark = bgColorActiveDark
        self.textItemColor = textItemColor
        self.textItemColorDark = textItemColorDark
        self.textItemColorActive = textItemColorActive
        self.textItemColorActiveDark = textItemColorActiveDark
        self.bgColorList = bgColorList
        self.bgColorDarkList = bgColorDarkList
        self.borderColorList = borderColorList
        self.borderColorDarkList = borderColorDarkList
        self.bgColorItemList = bgColorItemList
        self.bgColorItemDarkList = bgColorItemDarkList
        self.bgColorItemListActive = bgColorItemListActive
        self.bgColorItemDarkListActive = bgColorItemDarkListActive
        self.textColorLits = textColorLits
        self.textColorDarkList = textColorDarkList
        self.textColorLitsActive = textColorLitsActive
        self.textColorDarkListActive = textColorDarkListActive
        self.colorIndicator = colorIndicator
        self.titleFont = titleFont
        self.textFont = textFont
        self.textFontItem = textFontItem
        self.textFontItemActive = textFontItemActive
        self.uiRadius = uiRadius
        self.uiRadiusList = uiRadiusList
        self.marginTopList = marginTopList
        self.paddingVertical = paddingVertical
        self.paddingHorizontal = paddingHorizontal
        self.colorIndicatorDark = colorIndicatorDark
    }
    
}
