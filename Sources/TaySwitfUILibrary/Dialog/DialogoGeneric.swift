//
//  DialogoGeneric.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct CMDialogoGeneric: View {
    @Binding var mostrar: Bool
    public var title: String
    public var subTitle: String
    public var dialogStyle: DialogStyle
    public var dModle: DialogModel
    public let actionDialog: (Bool) -> Void
    public var styleConfig: DialogConfig
    
    public init(
        mostrar: Binding<Bool>,
        title: String = uiTextErrorGeneric,
        subTitle: String = uiTextErrorGeneric,
        dialogStyle: DialogStyle = DialogStyle.defaultStyle,
        dModle: DialogModel = DialogModel(),
        styleConfig: DialogConfig = IniTaySwitUI.styleDialog,
        actionDialog: @escaping (Bool) -> Void = { _ in }
    ) {
        self._mostrar = mostrar
        self.title = title
        self.subTitle = subTitle
        self.dialogStyle = dialogStyle
        self.dModle = dModle
        self.styleConfig = styleConfig
        self.actionDialog = actionDialog
    }
    public var body: some View {
        ZStack {
            dModle.bgColorDialog.ignoresSafeArea()
            VStack(spacing: 24) {
                if dModle.iconClose{
                    HStack {
                        Spacer()
                        Image(uiName:dModle.iconCloseName.isEmpty ? getIconClose() : dModle.iconCloseName)
                            .resizable()
                            .frame(width: styleConfig.sizeIconClose, height: styleConfig.sizeIconClose).onTapGesture {
                                actionDialog(false)
                                mostrar = false
                            }
                    }
                }
                if dModle.icon{
                    Image(uiName:dModle.iconName.isEmpty ? getIcon() : dModle.iconName)
                        .resizable().frame(width: styleConfig.sizeIcon, height: styleConfig.sizeIcon)
                }
                VStack(spacing: 12) {
                    Text(title)
                        .font(styleConfig.fontTitle)
                        .foregroundColor(getTextColor()).uiCenter()
                    
                    Text(subTitle)
                        .font(styleConfig.fontSubTitle)
                        .foregroundColor(getSubTextColor())
                        .uiCenter(line: 6)
                }
                .padding(.horizontal, 10)
                if dModle.btnPrimary{
                    VStack(spacing: 16) {
                        Button(action: {
                            actionDialog(true)
                            mostrar = false
                        }) {
                            Text(dModle.textBtn)
                                .font(styleConfig.fontBtn)
                                .foregroundColor(styleConfig.btnTextColor)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .bgRound(radius: styleConfig.cornerBtnRadius, bgColor: getBgBtnColor())
                                .padding(.horizontal,styleConfig.marginHorizontalBtn)
                        }
                        if dModle.btnSecundary{
                            Button(action: {
                                actionDialog(false)
                                mostrar = false }) {
                                    Text(dModle.textBtnSecundary)
                                        .font(styleConfig.fontBtnSecondary)
                                        .foregroundColor(getBgBtnSecondaryColor())
                                }
                        }
                        
                    }
                    .padding(.top, 10)
                }
            }
            .padding(styleConfig.paddingHorizontal)
            .background(
                RoundedRectangle(cornerRadius: styleConfig.cornerRadius)
                    .fill(Color.white)
            )
            .padding(.horizontal, styleConfig.marginHorizontal)
        }
    }
    
    private func getTextColor()->Color{
        switch dialogStyle{
        case .success:
            return styleConfig.titleColorSuccess
        case .warning:
            return styleConfig.titleColorWarning
        case .error:
            return styleConfig.titleColorError
        case .defaultStyle:
            return styleConfig.titleColorDefault
        }
    }
    
    private func getSubTextColor()->Color{
        switch dialogStyle{
        case .success:
            return styleConfig.subTitleColorSuccess
        case .warning:
            return styleConfig.subTitleColorWarning
        case .error:
            return styleConfig.subTitleColorError
        case .defaultStyle:
            return styleConfig.subTitleColor
        }
    }
    
    private func getBgBtnColor()->Color{
        switch dialogStyle{
        case .success:
            return styleConfig.bgBtnColorSuccess
        case .warning:
            return styleConfig.bgBtnColorWarning
        case .error:
            return styleConfig.bgBtnColorError
        case .defaultStyle:
            return styleConfig.bgBtnColor
        }
    }
    
    private func getBgBtnSecondaryColor()->Color{
        switch dialogStyle{
        case .success:
            return styleConfig.bgBtnSecondaryColorSuccess
        case .warning:
            return styleConfig.bgBtnSecondaryColorWarning
        case .error:
            return styleConfig.bgBtnSecondaryColorError
        case .defaultStyle:
            return styleConfig.bgBtnSecondaryColor
        }
    }
    
    private func getIcon()->String{
        switch dialogStyle{
        case .success:
            return styleConfig.nameIconSuccess
        case .warning:
            return styleConfig.nameIconWarning
        case .error:
            return styleConfig.nameIconError
        case .defaultStyle:
            return styleConfig.nameIcon
        }
    }
    
    private func getIconClose()->String{
        switch dialogStyle{
        case .success:
            return styleConfig.nameCloseIconSuccess
        case .warning:
            return styleConfig.nameCloseIconWarning
        case .error:
            return styleConfig.nameCloseIconError
        case .defaultStyle:
            return styleConfig.nameCloseIcon
        }
    }
}


struct DialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let subTitle: String
    let dialogStyle: DialogStyle
    let dModle: DialogModel
    let styleConfig: DialogConfig
    let action: (Bool) -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                dModle.bgColorDialog
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                CMDialogoGeneric(
                    mostrar: $isPresented,
                    title: title,
                    subTitle: subTitle,
                    dialogStyle: dialogStyle,
                    dModle: dModle,
                    styleConfig: styleConfig,
                    actionDialog: action
                )
                .zIndex(1)
            }
        }
        .animation(.spring(), value: isPresented)
    }
}


public struct DialogModel: Equatable {
    public var textBtn: String
    public var textBtnSecundary: String
    public var iconName: String
    public var iconCloseName: String
    public var icon: Bool
    public var iconClose: Bool
    public var btnSecundary: Bool
    public var btnPrimary: Bool
    public var bgColorDialog: Color
    
    public init(
        textBtn: String = btnUnderstood,
        textBtnSecundary: String = btnNotNow,
        iconName: String = uiEmpty,
        iconCloseName: String = uiEmpty,
        icon: Bool = true,
        iconClose: Bool = false,
        btnSecundary: Bool = false,
        btnPrimary: Bool = true,
        bgColorDialog: Color = Color.uiTransparent.opacity(0.8)
    ) {
        self.textBtn = textBtn
        self.textBtnSecundary = textBtnSecundary
        self.iconName = iconName
        self.iconCloseName = iconCloseName
        self.icon = icon
        self.iconClose = iconClose
        self.btnSecundary = btnSecundary
        self.btnPrimary = btnPrimary
        self.bgColorDialog = bgColorDialog
    }
}


public enum DialogStyle: Hashable {
    case success
    case error
    case warning
    case defaultStyle
}

public struct DialogConfig {
    public var titleColorDefault: Color
    public var titleColorSuccess: Color
    public var titleColorWarning: Color
    public var titleColorError: Color
    public var subTitleColor: Color
    public var subTitleColorSuccess: Color
    public var subTitleColorWarning: Color
    public var subTitleColorError: Color
    public var bgBtnColor: Color
    public var bgBtnColorSuccess: Color
    public var bgBtnColorWarning: Color
    public var bgBtnColorError: Color
    public var btnTextColor: Color = .white
    public var btnTextColorSuccess: Color = .white
    public var btnTextColorWarning: Color = .white
    public var btnTextColorError: Color = .white
    public var bgBtnSecondaryColor: Color
    public var bgBtnSecondaryColorSuccess: Color
    public var bgBtnSecondaryColorWarning: Color
    public var bgBtnSecondaryColorError: Color
    public var fontTitle: Font
    public var fontSubTitle: Font
    public var fontBtn: Font
    public var fontBtnSecondary: Font
    public var cornerRadius: CGFloat
    public var cornerBtnRadius: CGFloat
    public var marginHorizontal: CGFloat
    public var marginHorizontalBtn: CGFloat
    public var paddingHorizontal: CGFloat
    public var sizeIcon: CGFloat
    public var sizeIconClose: CGFloat
    public var nameIcon: String
    public var nameIconSuccess: String
    public var nameIconWarning: String
    public var nameIconError: String
    public var nameCloseIcon: String
    public var nameCloseIconSuccess: String
    public var nameCloseIconWarning: String
    public var nameCloseIconError: String
    public var fontTile: Font
    public var fontSubTile: Font
    public var uiFontBtn: Font
    public var uiFontBtnSecondary: Font
    
    public init(
        titleColorDefault: Color = .uiGrey800,
        titleColorSuccess: Color = .uiGrey800,
        titleColorWarning: Color = .uiGrey800,
        titleColorError: Color = .uiGrey800,
        subTitleColor: Color = .uiGrey800,
        subTitleColorSuccess: Color = .uiGrey800,
        subTitleColorWarning: Color = .uiGrey800,
        subTitleColorError: Color = .uiGrey800,
        bgBtnColor: Color = .uiBlack,
        bgBtnColorSuccess: Color = .uiBlack,
        bgBtnColorWarning: Color = .uiBlack,
        bgBtnColorError: Color = .uiRed900,
        btnTextColor: Color = .white,
        btnTextColorSuccess: Color = .white,
        btnTextColorWarning: Color = .white,
        btnTextColorError: Color = .white,
        bgBtnSecondaryColor: Color = .uiBlack,
        bgBtnSecondaryColorSuccess: Color = .uiBlack,
        bgBtnSecondaryColorWarning: Color = .uiBlack,
        bgBtnSecondaryColorError: Color = .uiRed900,
        fontTitle: Font = .uiMontS18,
        fontSubTitle: Font = .uiMontM14,
        fontBtn: Font = .uiMontB16,
        fontBtnSecondary: Font = .uiMontB16,
        cornerRadius: CGFloat = 24,
        cornerBtnRadius: CGFloat = 28,
        marginHorizontal: CGFloat = 16,
        marginHorizontalBtn: CGFloat = 0,
        paddingHorizontal: CGFloat = 24,
        sizeIcon : CGFloat = 60,
        sizeIconClose : CGFloat = 32,
        nameIcon: String = "ic_d_info",
        nameIconSuccess: String = "ic_d_success",
        nameIconWarning: String  = "ic_d_warning",
        nameIconError: String  = "ic_d_error",
        nameCloseIcon:  String = "ic_d_close",
        nameCloseIconSuccess:  String = "ic_d_close",
        nameCloseIconWarning: String = "ic_d_close",
        nameCloseIconError: String = "ic_d_close",
        fontTile: Font = Font.uiMontS25,
        fontSubTile: Font = Font.uiMontM14,
        uiFontBtn: Font = Font.uiMontB16,
        uiFontBtnSecondary: Font = Font.uiMontB16
    ) {
        self.titleColorDefault = titleColorDefault
        self.titleColorSuccess = titleColorSuccess
        self.titleColorWarning = titleColorWarning
        self.titleColorError = titleColorError
        self.subTitleColor = subTitleColor
        self.subTitleColorSuccess = subTitleColorSuccess
        self.subTitleColorWarning = subTitleColorWarning
        self.subTitleColorError = subTitleColorError
        self.bgBtnColor = bgBtnColor
        self.bgBtnColorSuccess = bgBtnColorSuccess
        self.bgBtnColorWarning = bgBtnColorWarning
        self.bgBtnColorError = bgBtnColorError
        self.btnTextColor = btnTextColor
        self.btnTextColorSuccess = btnTextColorSuccess
        self.btnTextColorWarning = btnTextColorWarning
        self.btnTextColorError = btnTextColorError
        self.bgBtnSecondaryColor = bgBtnSecondaryColor
        self.bgBtnSecondaryColorSuccess = bgBtnSecondaryColorSuccess
        self.bgBtnSecondaryColorWarning = bgBtnSecondaryColorWarning
        self.bgBtnSecondaryColorError = bgBtnSecondaryColorError
        self.fontTitle = fontTitle
        self.fontSubTitle = fontSubTitle
        self.fontBtn = fontBtn
        self.fontBtnSecondary = fontBtnSecondary
        self.cornerRadius = cornerRadius
        self.cornerBtnRadius = cornerBtnRadius
        self.marginHorizontal = marginHorizontal
        self.marginHorizontalBtn = marginHorizontalBtn
        self.paddingHorizontal = paddingHorizontal
        self.sizeIcon = sizeIcon
        self.sizeIconClose = sizeIconClose
        self.nameIcon = nameIcon
        self.nameIconSuccess = nameIconSuccess
        self.nameIconWarning  = nameIconWarning
        self.nameIconError  = nameIconError
        self.nameCloseIcon = nameCloseIcon
        self.nameCloseIconSuccess = nameCloseIconSuccess
        self.nameCloseIconWarning = nameCloseIconWarning
        self.nameCloseIconError = nameCloseIconError
        self.fontTile = fontTile
        self.fontSubTile = fontSubTile
        self.uiFontBtn = uiFontBtn
        self.uiFontBtnSecondary = uiFontBtnSecondary
    }
    
}
