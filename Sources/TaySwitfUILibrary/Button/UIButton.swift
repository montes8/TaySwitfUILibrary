//
//  UIButton.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct UIButton: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @State private var isPressed: Bool = false
    var text: String
    var styleBtn : BtnStyle
    var stylePresent : BtnPresent
    var iconStar : String
    var iconEnd : String
    var styleConfig : BtnConfig
    let action: () -> Void
    
    public init(
        text: String = "Continuar" ,
        styleBtn: BtnStyle = .primary,
        stylePresent : BtnPresent = .NotIcon,
        iconStar : String = "arrow.left",
        iconEnd : String = "arrow.left",
        styleConfig : BtnConfig = IniTaySwitUI.styleButton,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.styleBtn = styleBtn
        self.stylePresent = stylePresent
        self.iconStar = iconStar
        self.iconEnd = iconEnd
        self.styleConfig = styleConfig
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: styleConfig.uiPaddingIcon) {
            if(stylePresent == .completeIcon || stylePresent == .starIcon){
                Image(systemName: iconStar).resizable().renderingMode(.template)
                    .foregroundColor(textColor).frame(width: 24,height: 24)
            }
            Text(text)
                .font(styleConfig.uiFontBtn).foregroundColor(textColor)
            if(stylePresent == .completeIcon || stylePresent == .endIcon){
                Image(systemName:iconEnd).resizable().renderingMode(.template)
                    .foregroundColor(textColor).frame(width: 24,height: 24)
            }
        }
        .foregroundColor(textColor)
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .bgStroker(radius: styleConfig.uiCornerRadius, bgColor: backgroundColor, stroke: strokeColor)
        .scaleEffect(isPressed && isEnabled ? 0.96 : 1.0)
        .animation(.easeOut(duration: 1), value: isPressed)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if isEnabled { isPressed = true }
                }
                .onEnded { _ in
                    if isPressed && isEnabled {
                        action()
                    }
                    isPressed = false
                }
        )
        
    }
    
    private var backgroundColor: Color {
        if !isEnabled {
            return getColorBgDisable()
        }
        return isPressed ? getColorBgSelected() : getColorBgEnable()
    }
    
    private var textColor: Color {
        if !isEnabled {
            return getColorTextDisable()
        }
        return isPressed ? getColorTextActive() : getColorTextEnable()
    }
    
    private var strokeColor: Color {
        if !isEnabled {
            return getColorStrokeDisable()
        }
        return isPressed ? getColorStrokeSelected() : getColorStrokeEnable()
    }
    
    private func getColorBgEnable()->Color{
        switch styleBtn{
        case .primary:
            return styleConfig.bgColorPrimary
        case .secondary:
            return styleConfig.bgColorSecondary
        case .tertiary:
            return styleConfig.bgColorTerciary
        case .quaternary:
            return styleConfig.bgColorQuaternary
        }
    }
    
    private func getColorBgSelected()->Color{
        switch styleBtn{
        case .primary:
            return styleConfig.bgColorPrimaryActive
        case .secondary:
            return styleConfig.bgColorSecondaryActive
        case .tertiary:
            return styleConfig.bgColorTerciaryActive
        case .quaternary:
            return styleConfig.bgColorQuaternaryActive
        }
    }
    private func getColorBgDisable()->Color{
        switch styleBtn{
        case .primary:
            return styleConfig.bgColorPrimaryDisable
        case .secondary:
            return styleConfig.bgColorSecondaryDisable
        case .tertiary:
            return styleConfig.bgColorTerciaryDisable
        case .quaternary:
            return styleConfig.bgColorQuaternaryDisable
        }
    }
    
    private func getColorStrokeEnable()->Color{
        switch styleBtn{
        case .primary:
            return styleConfig.strokeColorPrimary
        case .secondary:
            return styleConfig.strokeColorSecondary
        case .tertiary:
            return styleConfig.strokeColorTerciary
        case .quaternary:
            return styleConfig.strokeColorQuaternary
        }
    }
    
    private func getColorStrokeSelected()->Color{
        switch styleBtn{
        case .primary:
            return styleConfig.strokeColorPrimaryActive
        case .secondary:
            return styleConfig.strokeColorSecondaryActive
        case .tertiary:
            return styleConfig.strokeColorTerciaryActive
        case .quaternary:
            return styleConfig.strokeColorQuaternaryActive
        }
    }
    private func getColorStrokeDisable()->Color{
        switch styleBtn{
        case .primary:
            return styleConfig.strokeColorPrimaryDisable
        case .secondary:
            return styleConfig.strokeColorSecondaryDisable
        case .tertiary:
            return styleConfig.strokeColorTerciaryDisable
        case .quaternary:
            return styleConfig.strokeColorQuaternaryDisable
        }
    }
    
    private func getColorTextEnable()->Color{
        switch styleBtn{
        case .primary:
            return styleConfig.labelColorPrimary
        case .secondary:
            return styleConfig.labelColorSecondary
        case .tertiary:
            return styleConfig.labelColorTerciary
        case .quaternary:
            return styleConfig.labelColorQuaternary
        }
    }
    
    private func getColorTextActive()->Color{
        switch styleBtn{
        case .primary:
            return styleConfig.labelColorPrimaryActive
        case .secondary:
            return styleConfig.labelColorSecondaryActive
        case .tertiary:
            return styleConfig.labelColorTerciaryActive
        case .quaternary:
            return styleConfig.labelColorQuaternaryActive
        }
    }
    
    
    private func getColorTextDisable()->Color{
        switch styleBtn{
        case .primary:
            return styleConfig.labelColorPrimaryDisable
        case .secondary:
            return styleConfig.labelColorSecondaryDisable
        case .tertiary:
            return styleConfig.labelColorTerciaryDisable
        case .quaternary:
            return styleConfig.labelColorQuaternaryDisable
        }
    }
}


public enum BtnPresent: Hashable {
    case completeIcon
    case starIcon
    case endIcon
    case NotIcon
}
public enum BtnStyle: Hashable {
    case primary
    case secondary
    case tertiary
    case quaternary
}

public struct BtnConfig{
    var labelColorPrimary : Color = Color.white
    var labelColorSecondary :  Color = Color.uiBlack
    var labelColorTerciary : Color = Color.uiBlack
    var labelColorQuaternary : Color = Color.uiBlack
    var labelColorPrimaryActive : Color = Color.white
    var labelColorSecondaryActive : Color  = Color.uiBlack
    var labelColorTerciaryActive : Color = Color.uiBlack
    var labelColorQuaternaryActive : Color = Color.uiBlack
    var labelColorPrimaryDisable : Color = Color.uiGrey400
    var labelColorSecondaryDisable : Color = Color.uiGrey400
    var labelColorTerciaryDisable : Color = Color.uiGrey400
    var labelColorQuaternaryDisable : Color = Color.uiGrey400
    var bgColorPrimary : Color = Color.uiBlack
    var bgColorSecondary :  Color = Color.uiGrey100
    var bgColorTerciary : Color = Color.white
    var bgColorQuaternary : Color = Color.white
    var bgColorPrimaryActive : Color = Color.uiBlack
    var bgColorSecondaryActive : Color  = Color.uiGrey200
    var bgColorTerciaryActive : Color = Color.uiBlack
    var bgColorQuaternaryActive : Color = Color.uiBlack
    var bgColorPrimaryDisable : Color = Color.uiGrey200
    var bgColorSecondaryDisable : Color = Color.uiGrey200
    var bgColorTerciaryDisable : Color = Color.white
    var bgColorQuaternaryDisable : Color = Color.white
    var strokeColorPrimary : Color = Color.uiBlack
    var strokeColorSecondary :  Color = Color.uiGrey200
    var strokeColorTerciary : Color = Color.white
    var strokeColorQuaternary : Color = Color.white
    var strokeColorPrimaryActive : Color = Color.uiBlack
    var strokeColorSecondaryActive : Color  = Color.uiGrey200
    var strokeColorTerciaryActive : Color = Color.white
    var strokeColorQuaternaryActive : Color = Color.white
    var strokeColorPrimaryDisable : Color = Color.uiGrey200
    var strokeColorSecondaryDisable : Color = Color.uiGrey200
    var strokeColorTerciaryDisable : Color = Color.white
    var strokeColorQuaternaryDisable : Color = Color.white
    var uiFontBtn : Font = .uiMontB16
    var uiCornerRadius: CGFloat = 28
    var uiPaddingIcon: CGFloat = 10
    
    public init(
        labelColorPrimary: Color = .white,
        labelColorSecondary: Color = .uiBlack,
        labelColorTerciary: Color = .uiBlack,
        labelColorQuaternary: Color = .uiBlack,
        labelColorPrimaryActive: Color = .white,
        labelColorSecondaryActive: Color = .uiBlack,
        labelColorTerciaryActive: Color = .uiBlack,
        labelColorQuaternaryActive: Color = .uiBlack,
        labelColorPrimaryDisable: Color = .uiGrey400,
        labelColorSecondaryDisable: Color = .uiGrey400,
        labelColorTerciaryDisable: Color = .uiGrey400,
        labelColorQuaternaryDisable: Color = .uiGrey400,
        bgColorPrimary: Color = .uiBlack,
        bgColorSecondary: Color = .uiBlack,
        bgColorTerciary: Color = .white,
        bgColorQuaternary: Color = .white,
        bgColorPrimaryActive: Color = .uiBlack,
        bgColorSecondaryActive: Color = .uiGrey200,
        bgColorTerciaryActive: Color = .uiBlack,
        bgColorQuaternaryActive: Color = .uiBlack,
        bgColorPrimaryDisable: Color = .uiGrey200,
        bgColorSecondaryDisable: Color = .uiGrey200,
        bgColorTerciaryDisable: Color = .white,
        bgColorQuaternaryDisable: Color = .white,
        strokeColorPrimary: Color = .uiBlack,
        strokeColorSecondary: Color = .uiGrey200,
        strokeColorTerciary: Color = .white,
        strokeColorQuaternary: Color = .white,
        strokeColorPrimaryActive: Color = .uiBlack,
        strokeColorSecondaryActive: Color = .uiGrey200,
        strokeColorTerciaryActive: Color = .white,
        strokeColorQuaternaryActive: Color = .white,
        strokeColorPrimaryDisable: Color = .uiGrey200,
        strokeColorSecondaryDisable: Color = .uiGrey200,
        strokeColorTerciaryDisable: Color = .white,
        strokeColorQuaternaryDisable: Color = .white,
        uiFontBtn: Font = .uiMontB16,
        uiCornerRadius: CGFloat = 28,
        uiPaddingIcon: CGFloat = 10
    ) {self.labelColorPrimary = labelColorPrimary
        self.labelColorSecondary = labelColorSecondary
        self.labelColorTerciary = labelColorTerciary
        self.labelColorQuaternary = labelColorQuaternary
        self.labelColorPrimaryActive = labelColorPrimaryActive
        self.labelColorSecondaryActive = labelColorSecondaryActive
        self.labelColorTerciaryActive = labelColorTerciaryActive
        self.labelColorQuaternaryActive = labelColorQuaternaryActive
        self.labelColorPrimaryDisable = labelColorPrimaryDisable
        self.labelColorSecondaryDisable = labelColorSecondaryDisable
        self.labelColorTerciaryDisable = labelColorTerciaryDisable
        self.labelColorQuaternaryDisable = labelColorQuaternaryDisable
        self.bgColorPrimary = bgColorPrimary
        self.bgColorSecondary = bgColorSecondary
        self.bgColorTerciary = bgColorTerciary
        self.bgColorQuaternary = bgColorQuaternary
        self.bgColorPrimaryActive = bgColorPrimaryActive
        self.bgColorSecondaryActive = bgColorSecondaryActive
        self.bgColorTerciaryActive = bgColorTerciaryActive
        self.bgColorQuaternaryActive = bgColorQuaternaryActive
        self.bgColorPrimaryDisable = bgColorPrimaryDisable
        self.bgColorSecondaryDisable = bgColorSecondaryDisable
        self.bgColorTerciaryDisable = bgColorTerciaryDisable
        self.bgColorQuaternaryDisable = bgColorQuaternaryDisable
        self.strokeColorPrimary = strokeColorPrimary
        self.strokeColorSecondary = strokeColorSecondary
        self.strokeColorTerciary = strokeColorTerciary
        self.strokeColorQuaternary = strokeColorQuaternary
        self.strokeColorPrimaryActive = strokeColorPrimaryActive
        self.strokeColorSecondaryActive = strokeColorSecondaryActive
        self.strokeColorTerciaryActive = strokeColorTerciaryActive
        self.strokeColorQuaternaryActive = strokeColorQuaternaryActive
        self.strokeColorPrimaryDisable = strokeColorPrimaryDisable
        self.strokeColorSecondaryDisable = strokeColorSecondaryDisable
        self.strokeColorTerciaryDisable = strokeColorTerciaryDisable
        self.strokeColorQuaternaryDisable = strokeColorQuaternaryDisable
        self.uiFontBtn = uiFontBtn
        self.uiCornerRadius = uiCornerRadius
        self.uiPaddingIcon = uiPaddingIcon
    }
    
    
}
