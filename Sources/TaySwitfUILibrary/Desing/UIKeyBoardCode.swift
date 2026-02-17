//
//  UIKeyBoardCode.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 17/02/26.
//

import SwiftUI

public struct UIKeyBoardCode: View {
    @Binding var uiCode: String
    let keys: [String]
    var title: String
    var subTitle: String
    var maxDigits: Int = 6
    var uiWidth: CGFloat = 0
    var uiHeigth: CGFloat = 0
    var styleConfig: KeyBoardConfig = KeyBoardConfig()
    var styleLight : Bool = true
    var uiTint: Bool = true
    var uiTintColorIcon: Color? = nil
    var uiFontTitle: Font = Font.uiMontS14
    var onBiometric: () -> Void = {}
    var onChange: (String) -> Void = {_ in }
    let columns: [GridItem]
    public init(
        uiCode: Binding<String>,
        keys: [String],
        title: String = uiTitleKeyboard,
        subTitle: String = uiEmpty,
        maxDigits :Int = 6,
        uiWidth: CGFloat = 0,
        uiHeigth: CGFloat = 0,
        styleConfig : KeyBoardConfig = IniTaySwitUI.styleKeyboardCode,
        styleLight : Bool = true,
        uiTint : Bool = true,
        uiTintColorIcon: Color? = nil,
        uiFontTitle : Font = Font.uiMontS14,
        onBiometric: @escaping () -> Void = {},
        onChange: @escaping (String) -> Void = { _ in }
    ) {
        self._uiCode = uiCode
        self.keys = keys
        self.title = title
        self.subTitle = subTitle
        self.maxDigits = maxDigits
        self.uiWidth = uiWidth
        self.uiHeigth = uiHeigth
        self.styleConfig = styleConfig
        self.styleLight = styleLight
        self.uiTint = uiTint
        self.uiTintColorIcon = uiTintColorIcon
        self.uiFontTitle = uiFontTitle
        self.onBiometric = onBiometric
        self.onChange = onChange
        self.columns = [
            GridItem(.flexible(), spacing: styleConfig.mItemHorizontal),
            GridItem(.flexible(), spacing: styleConfig.mItemHorizontal),
            GridItem(.flexible(), spacing: styleConfig.mItemHorizontal)
        ]
    }
    
    var cmColorText: Color {
        return styleLight ? styleConfig.titleColor : styleConfig.titleColorDark
    }
    
    var cmColorBgIndication: Color {
        return styleLight ? styleConfig.indicationColor  : styleConfig.indicationColorDark
    }
    
    var cmColorBgIndicationActive: Color {
        return styleLight ? styleConfig.indicationColorActive : styleConfig.indicationColorActiveDark
    }
    
    var cmColorBorderIndication: Color {
        return styleLight ? styleConfig.indicationBorderColor : styleConfig.indicationBorderColorDark
    }
    
    var cmColorBorderIndicationActive: Color {
        return styleLight ? styleConfig.indicationBorderColorActive : styleConfig.indicationBorderColorActiveDark
    }
    
    var cmColorBgIndicationStartActive: Color {
        return styleLight ? styleConfig.indicationColorActiveStart : styleConfig.indicationColorActiveStartDark
    }
    
    public var body: some View {
        VStack(spacing: styleConfig.spacingView) {
            Text(title)
                .font(uiFontTitle)
                .foregroundColor(cmColorText)
                .padding(.horizontal, styleConfig.mHorizontalGeneral)
            
            if(!subTitle.isEmpty){
                Text(subTitle)
                    .font(styleConfig.subTitleFont)
                    .lineSpacing(3)
                    .foregroundColor(cmColorText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 34)
                
                
            }
            
            HStack(spacing: styleConfig.mIndicatorHorizontal) {
                ForEach(0..<maxDigits, id: \.self) { index in
                    Circle()
                        .fill(index < uiCode.count ? LinearGradient(
                            colors: [cmColorBgIndicationActive, cmColorBgIndicationStartActive],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) : LinearGradient(colors: [cmColorBgIndication], startPoint: .center, endPoint: .center))
                        .frame(width: styleConfig.widthIndication, height: styleConfig.heigthIndication)
                        .overlay(
                            Circle()
                                .stroke(index < uiCode.count ?
                                        cmColorBorderIndicationActive : cmColorBorderIndication,
                                        lineWidth: styleConfig.lineIndication)
                        )
                        .animation(.linear(duration: 0.2), value: uiCode.count)
                }
            }
            Spacer().frame(height: 4)
            LazyVGrid(columns: columns, spacing: styleConfig.mItemVetical) {
                ForEach(keys, id: \.self) { key in
                    Button(action: {
                        handleKeyPress(key)
                    }) {
                        KeyView(key: key,
                                uiWidth:uiWidth,
                                uiHeigth:uiHeigth,
                                styleConfig:styleConfig,
                                styleLight:styleLight,
                                uiTint:uiTint,
                                uiTintColorIcon:uiTintColorIcon
                                
                        )
                    }.buttonStyle(KeyPadButtonStyle(key: key,
                                                    uiWidth:uiWidth,
                                                    uiHeigth:uiHeigth,
                                                    styleConfig:styleConfig,
                                                    styleLight:styleLight,
                                                    uiTint:uiTint,
                                                    uiTintColorIcon:uiTintColorIcon))
                }
            }
            .padding(.horizontal, styleConfig.mHorizontalGeneral)
        }.onChange(of: uiCode) { newValue in
            onChange(newValue)
        }
    }
    
    private func handleKeyPress(_ key: String) {
        if key == "delete" {
            if !uiCode.isEmpty {
                uiCode.removeLast()
            }
        } else if key == "faceid" || key == "fingerid"{
            onBiometric()
        } else {
            if(key.isEmpty){return}
            if uiCode.count < maxDigits {
                uiCode.append(key)
            }
        }
    }
}


public struct KeyView: View {
    let key: String
    var uiWidth: CGFloat
    var uiHeigth: CGFloat
    var styleConfig: KeyBoardConfig
    var styleLight : Bool
    var uiTint: Bool
    var uiTintColorIcon: Color?
    var isPressed: Bool = false
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: styleConfig.radiusBgItem)
                .fill(key.isEmpty ? .clear : validTypeKey() ? configBgIconItem() : configBgItem() )
                .frame(height: styleConfig.itemHeigth)
                .overlay(
                    Circle()
                        .stroke(key.isEmpty ? .clear : validTypeKey() ? configBorderItemIcon(): configBorderItem(),
                                lineWidth: styleConfig.lineItem).cornerRadius(styleConfig.radiusBgItem)
                )
            
            if key == "faceid" || key == "fingerid"{
                Image(uiName:  key == "faceid" ? "ic_cm_face_id" : "ic_cm_finger_id" )
                    .resizable()
                    .renderingMode(uiTint == true ? .template : .original)
                    .foregroundColor(uiTintColorIcon == nil && uiTint == true ? styleConfig.iconColorItem : uiTintColorIcon)
                    .frame(width: styleConfig.sizeIcon,height: styleConfig.sizeIcon)
            } else if key == "delete" {
                Image(uiName: "ic_cm_delete")
                    .resizable()
                    .renderingMode(uiTint == true ? .template : .original)
                    .foregroundColor(styleConfig.iconColorItem)
                    .frame(width: styleConfig.sizeIcon,height: styleConfig.sizeIcon)
            } else {
                Text(key)
                    .font(styleConfig.itemFont)
            }
        }.foregroundColor(isPressed ? cmColorTextItemColorActive : cmColorTextItemColor)
            .frame( maxWidth: uiWidth == 0 ? .infinity :uiWidth, maxHeight: uiHeigth == 0 ? .infinity : uiHeigth)
    }
    
    private func validTypeKey()->Bool{
        return key.count > 1
    }
    
    var cmColorBgItemColorActive: Color {
        return styleLight ? styleConfig.bgItemBorderColorActive : styleConfig.bgItemBorderColorActiveDark
    }
    
    var cmColorBgItemColor: Color {
        return styleLight ? styleConfig.bgItemBorderColor : styleConfig.bgItemBorderColorDark
    }
    
    var cmColorBoderItemColorActive: Color {
        return styleLight ? styleConfig.bgItemBorderColorActive : styleConfig.bgItemBorderColorActiveDark
    }
    
    var cmColorBoderItemColor: Color {
        return styleLight ? styleConfig.bgItemBorderColor : styleConfig.bgItemBorderColorDark
    }
    
    
    var cmColorTextItemColorActive: Color {
        return styleLight ? styleConfig.itemTextColorActive : styleConfig.itemTextColorActiveDark
    }
    
    
    var cmColorTextItemColor: Color {
        return styleLight ? styleConfig.itemTextColor : styleConfig.itemTextColorDark
    }
    
    private func configBgItem()->Color{
        return isPressed ? cmColorBgItemColorActive : cmColorBgItemColor
    }
    
    private func configBgIconItem()->Color{
        return isPressed ? cmColorBgItemIconColorActive : cmColorBgItemIconColor
    }
    
    var cmColorBgItemIconColorActive: Color {
        return styleLight ? styleConfig.bgItemIconColorActive : styleConfig.bgItemIconColorActiveDark
    }
    
    var cmColorBgItemIconColor: Color {
        return styleLight ? styleConfig.bgItemIconColor: styleConfig.bgItemIconColorDark
    }
    
    private func configBorderItem()->Color{
        return isPressed ? cmColorBoderItemColorActive : cmColorBoderItemColor
    }
    
    private func configBorderItemIcon()->Color{
        return isPressed ? cmColorBoderItemIconColorActive : cmColorBoderItemIconColor
    }
    
    var cmColorBoderItemIconColorActive: Color {
        return styleLight ? styleConfig.bgItemIconBorderColorActive : styleConfig.bgItemIconBorderColorActiveDark
    }
    
    var cmColorBoderItemIconColor: Color {
        return styleLight ? styleConfig.bgItemIconBorderColor : styleConfig.bgItemIconBorderColorDark
    }
    
}

public struct KeyPadButtonStyle: ButtonStyle {
    let key: String
    var uiWidth: CGFloat
    var uiHeigth: CGFloat
    var styleConfig: KeyBoardConfig
    var styleLight : Bool
    var uiTint: Bool = true
    var uiTintColorIcon: Color?
    public func makeBody(configuration: Configuration) -> some View {
        KeyView(key: key,uiWidth: uiWidth,uiHeigth: uiHeigth,styleConfig: styleConfig,styleLight:styleLight,uiTint: uiTint,
                uiTintColorIcon:uiTintColorIcon ,isPressed: configuration.isPressed)
        .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
        .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

public struct KeyBoardConfig{
    var mItemHorizontal : CGFloat = 16
    var mHorizontalGeneral : CGFloat = 0
    var mIndicatorHorizontal : CGFloat = 16
    var mItemVetical : CGFloat = 20
    var titleColor : Color
    var subTitleColor : Color
    var titleColorDark : Color
    var subTitleColorDark : Color
    var subTitleFont : Font
    var itemFont : Font
    var widthIndication : CGFloat = 8
    var heigthIndication : CGFloat = 8
    var lineIndication : CGFloat = 1
    var lineItem : CGFloat = 1
    var indicationColor : Color
    var indicationColorActive : Color
    var indicationColorActiveStart : Color
    var indicationBorderColor : Color
    var indicationBorderColorActive : Color
    var bgItemColor : Color
    var bgItemColorActive : Color
    var bgItemBorderColor : Color
    var bgItemBorderColorActive : Color
    var itemTextColor : Color
    var itemTextColorActive : Color
    var iconColorItem : Color
    var indicationColorDark : Color
    var indicationColorActiveDark : Color
    var indicationColorActiveStartDark : Color
    var indicationBorderColorDark : Color
    var indicationBorderColorActiveDark : Color
    var bgItemColorDark : Color
    var bgItemColorActiveDark : Color
    var bgItemBorderColorDark : Color
    var bgItemBorderColorActiveDark : Color
    var itemTextColorDark : Color
    var itemTextColorActiveDark : Color
    var iconColorItemDark : Color
    var bgItemIconColor : Color
    var bgItemIconColorActive : Color
    var bgItemIconBorderColor : Color
    var bgItemIconBorderColorActive : Color
    var bgItemIconColorDark : Color
    var bgItemIconColorActiveDark : Color
    var bgItemIconBorderColorDark : Color
    var bgItemIconBorderColorActiveDark : Color
    var sizeIcon : CGFloat = 32
    var radiusBgItem : CGFloat = 32
    var itemHeigth : CGFloat = 60
    var spacingView : CGFloat = 16
    
    init(mItemHorizontal : CGFloat = 16,
         mHorizontalGeneral : CGFloat = 0,
         mIndicatorHorizontal : CGFloat = 16,
         mItemVetical : CGFloat = 20,
         titleColor : Color = Color.uiGrey800,
         subTitleColor : Color = Color.uiGrey800,
         titleColorDark : Color = Color.uiGrey800,
         subTitleColorDark : Color = Color.uiGrey800,
         subTitleFont : Font = Font.uiMontM14,
         itemFont : Font = Font.uiMontS25,
         widthIndication : CGFloat = 8,
         heigthIndication : CGFloat = 8,
         lineIndication : CGFloat = 1.5,
         lineItem : CGFloat = 1.5,
         indicationColor : Color = Color.uiGrey100,
         indicationColorActive : Color = Color.uiBlack,
         indicationColorActiveStart : Color = Color.uiBlack,
         indicationBorderColor : Color = Color.uiGrey100,
         indicationBorderColorActive : Color = Color.uiBlack,
         bgItemColor : Color = Color.uiGrey100,
         bgItemColorActive : Color = Color.uiGrey200,
         bgItemBorderColor : Color = Color.uiGrey100,
         bgItemBorderColorActive : Color = Color.uiGrey200,
         itemTextColor : Color = Color.uiGrey800,
         itemTextColorActive : Color = Color.uiGrey800,
         iconColorItem : Color = Color.uiBlack,
         indicationColorDark : Color = Color.uiGrey100,
         indicationColorActiveDark : Color = Color.uiBlack,
         indicationColorActiveStartDark : Color = Color.uiBlack,
         indicationBorderColorDark : Color = Color.uiGrey100,
         indicationBorderColorActiveDark : Color = Color.uiBlack,
         bgItemColorDark : Color = Color.uiGrey100,
         bgItemColorActiveDark : Color = Color.uiGrey200,
         bgItemBorderColorDark : Color = Color.uiGrey100,
         bgItemBorderColorActiveDark : Color = Color.uiGrey200,
         itemTextColorDark : Color = Color.uiGrey800,
         itemTextColorActiveDark : Color = Color.uiGrey800,
         iconColorItemDark : Color = Color.uiBlack,
         bgItemIconColor : Color = Color.uiGrey100,
         bgItemIconColorActive : Color = Color.uiGrey200,
         bgItemIconBorderColor : Color = Color.uiGrey100,
         bgItemIconBorderColorActive : Color = Color.uiGrey200,
         bgItemIconColorDark : Color = Color.uiGrey100,
         bgItemIconColorActiveDark : Color = Color.uiGrey200,
         bgItemIconBorderColorDark : Color = Color.uiGrey100,
         bgItemIconBorderColorActiveDark : Color = Color.uiGrey200,
         sizeIcon : CGFloat = 32,
         radiusBgItem : CGFloat = 14,
         itemHeigth : CGFloat = 60,
         spacingView : CGFloat = 16) {
        self.mItemHorizontal = mItemHorizontal
        self.mHorizontalGeneral = mHorizontalGeneral
        self.mIndicatorHorizontal = mIndicatorHorizontal
        self.mItemVetical = mItemVetical
        self.titleColor = titleColor
        self.subTitleColor = subTitleColor
        self.titleColorDark = titleColorDark
        self.subTitleColorDark = subTitleColorDark
        self.subTitleFont = subTitleFont
        self.itemFont = itemFont
        self.widthIndication = widthIndication
        self.heigthIndication = heigthIndication
        self.lineIndication = lineIndication
        self.lineItem = lineItem
        self.indicationColor = indicationColor
        self.indicationColorActive = indicationColorActive
        self.indicationColorActiveStart = indicationColorActiveStart
        self.indicationBorderColor = indicationBorderColor
        self.indicationBorderColorActive = indicationBorderColorActive
        self.bgItemColor = bgItemColor
        self.bgItemColorActive = bgItemColorActive
        self.bgItemBorderColor = bgItemBorderColor
        self.bgItemBorderColorActive = bgItemBorderColorActive
        self.itemTextColor = itemTextColor
        self.itemTextColorActive = itemTextColorActive
        self.iconColorItem = iconColorItem
        self.indicationColorDark =  indicationColorDark
        self.indicationColorActiveDark =  indicationColorActiveDark
        self.indicationColorActiveStartDark =  indicationColorActiveStartDark
        self.indicationBorderColorDark =  indicationBorderColorDark
        self.indicationBorderColorActiveDark =  indicationBorderColorActiveDark
        self.bgItemColorDark =  bgItemColorDark
        self.bgItemColorActiveDark =  bgItemColorActiveDark
        self.bgItemBorderColorDark =  bgItemBorderColorDark
        self.bgItemBorderColorActiveDark =  bgItemBorderColorActiveDark
        self.itemTextColorDark =  itemTextColorDark
        self.itemTextColorActiveDark =  itemTextColorActiveDark
        self.iconColorItemDark =  iconColorItemDark
        self.bgItemIconColor = bgItemIconColor
        self.bgItemIconColorActive = bgItemIconColorActive
        self.bgItemIconBorderColor = bgItemIconBorderColor
        self.bgItemIconBorderColorActive = bgItemIconBorderColorActive
        self.bgItemIconColorDark = bgItemIconColorDark
        self.bgItemIconColorActiveDark = bgItemIconColorActiveDark
        self.bgItemIconBorderColorDark = bgItemIconBorderColorDark
        self.bgItemIconBorderColorActiveDark = bgItemIconBorderColorActiveDark
        self.sizeIcon = sizeIcon
        self.radiusBgItem = radiusBgItem
        self.itemHeigth = itemHeigth
        self.spacingView = spacingView
    }
    
}
