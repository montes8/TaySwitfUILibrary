//
//  UITextField.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct CMTextField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    @Binding var dataAlert: DataAlert
    var isDisabled: Bool
    var maxLength : Int
    var uiKeyboardType: UIKeyboardType
    var filtertext: FilterCaracter
    var model: EditModel
    var styleLight: Bool
    var styleMultiline: Bool
    var styleConfig: EditConfig
    var blockingCopyPaste: Bool
    var actionIcon: () -> Void = { }
    var uiChangeText: () -> Void = { }
    var uiFocusDetected: (Bool) -> Void = { _ in}
    @FocusState private var isFocused: Bool
    @State var typeSure : Bool = false
    @State var detectedFocus: Bool = false
    
    public init(
        label: String,
        placeholder: String,
        text: Binding<String>,
        dataAlert: Binding<DataAlert> = .constant(DataAlert()),
        isDisabled: Bool = false,
        maxLength : Int = 30,
        uiKeyboardType: UIKeyboardType = .asciiCapable,
        filtertext: FilterCaracter = .alphaNUmeric,
        model: EditModel = EditModel(),
        styleLight: Bool = true,
        styleMultiline: Bool = false,
        styleConfig: EditConfig = IniTaySwitUI.styleEdit,
        blockingCopyPaste: Bool = false,
        actionIcon: @escaping () -> Void = { },
        uiChangeText: @escaping () -> Void = { },
        uiFocusDetected: @escaping (Bool) -> Void = { _ in}
    ) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
        self._dataAlert = dataAlert
        self.isDisabled = isDisabled
        self.maxLength = maxLength
        self.uiKeyboardType = uiKeyboardType
        self.filtertext = filtertext
        self.model = model
        self.styleLight = styleLight
        self.styleMultiline = styleMultiline
        self.styleConfig = styleConfig
        self.blockingCopyPaste = blockingCopyPaste
        self.actionIcon = actionIcon
        self.uiChangeText = uiChangeText
        self.uiFocusDetected = uiFocusDetected
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if(model.titleSee){
                Text(label)
                    .font(styleMultiline ? styleConfig.titleFontMulti:styleConfig.titleFont)
                    .foregroundColor(currentTextColor)
            }
            HStack() {
                ZStack{
                    if(typeSure && !styleMultiline){
                        SecureField(uiEmpty, text: $text,prompt: Text(placeholder)
                            .foregroundColor(.uiGrey400)
                            .font(styleMultiline ? styleConfig.editFontMulti :styleConfig.editFont))
                        .foregroundColor(currentTextFieldColor)
                        .font(styleMultiline ? styleConfig.editFontMulti :styleConfig.editFont)
                    }else{
                        if(styleMultiline){
                            TextEditor(text: $text)
                                .foregroundColor(currentTextFieldColor)
                                .font(styleConfig.editFontMulti)
                                .frame(height:styleConfig.heigthEditMulti).onAppear {
                                    UITextView.appearance().backgroundColor = .clear
                                }.background(Color.clear).overlay(
                                    Group {
                                        if text.isEmpty {
                                            Text(placeholder)
                                                .font(styleConfig.editFontMulti)
                                                .foregroundColor(.cmGray400)
                                                .allowsHitTesting(false).padding(.vertical,6).padding(.horizontal,4)
                                        }
                                    },
                                    alignment: .topLeading
                                )
                        }else{
                            TextField(uiEmpty, text: $text,prompt: Text(placeholder)
                                .foregroundColor(.uiGrey400)
                                .font(styleConfig.editFont))
                            .foregroundColor(currentTextFieldColor)
                            .font(styleConfig.editFont)
                            .disableCopyPaste(blockingCopyPaste)
                        }
                        
                    }
                }.safeAreaInset(edge:.leading){
                    if(model.stylePresent == .completeIcon || model.stylePresent == .starIcon && !styleMultiline){
                        Image(cmName: model.nameIconStart).resizable().renderingMode(.template)
                            .foregroundColor(model.iconColorDefault ? .clear : currentTextColor)
                            .frame(width: 24, height: 24)
                    }
                }.safeAreaInset(edge:.trailing){
                    if(model.stylePresent == .completeIcon || model.stylePresent == .endIcon && !styleMultiline){
                        Button(action: {
                            if model.typeSecret{typeSure.toggle()}
                            actionIcon()}
                        ) {
                            Image(cmName : model.nameIconEnd).resizable().renderingMode(.template)
                                .foregroundColor(model.iconColorDefault ? .clear : currentTextColor)
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                .focused($isFocused)
                .keyboardType(cmKeyboardType)
                .disabled(isDisabled)
                .font(styleMultiline ? styleConfig.editFontMulti :styleConfig.editFont)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .textContentType(.oneTimeCode)
                .foregroundColor(currentTextColor)
                .preferredColorScheme(.light)
                
            }.onChange(of: text) { newValue in
                if(model.addSpace > 0){
                    let cleaned = newValue.replacingOccurrences(of: uiSpace, with: uiEmpty)
                    var formatted = uiEmpty
                    for (index, character) in cleaned.enumerated() {
                        if index > 0 && model.addSpace > 0 && index % model.addSpace == 0 {
                            formatted.append(uiSpace)
                        }
                        formatted.append(character)
                    }
                    if formatted.count <= maxLength {
                        text = formatted.validCaracterEdit(filtertext)
                    } else {
                        text = String(formatted.validCaracterEdit(filtertext).prefix(maxLength))
                    }
                }else{
                    if(!styleMultiline){
                        if newValue.count <= maxLength {
                            text = newValue.validCaracterEdit(filtertext)
                        } else {
                            text = String(newValue.validCaracterEdit(filtertext).prefix(maxLength))
                        }
                    }
                    
                }
                dataAlert = DataAlert()
                cmChangeText()
                
            }.onChange(of: isFocused) { newValue in
                
                if(isFocused){
                    if(detectedFocus){cmFocusDetected(isFocused)}
                    detectedFocus = true
                }else{
                    if(detectedFocus){cmFocusDetected(isFocused)}
                }
                if newValue && dataAlert.isAlertMessage.wrappedValue { dataAlert.isAlertMessage.wrappedValue = false }
            }
            .padding(.horizontal, styleMultiline ? 8:styleConfig.paddingHorizontal)
            .padding(.vertical, styleMultiline ? 4:styleConfig.paddingVertical)
            .background(
                RoundedRectangle(cornerRadius: styleMultiline ? styleConfig.uiRadiusMulti:styleConfig.uiRadius)
                    .stroke(currentBorderColor, lineWidth: 2)
                    .background(currentColor)
            )
            .cornerRadius(styleMultiline ? styleConfig.uiRadiusMulti:styleConfig.uiRadius)
            if(dataAlert.isAlertMessage.wrappedValue){
                Text(dataAlert.textAlert.wrappedValue)
                    .font(styleMultiline ? styleConfig.editFontMessageMulti : styleConfig.editFontMessage)
                    .foregroundColor(colorAlert)
            }
        }
    }
    
    private var colorDefault: Color {
        return styleLight ? styleConfig.uiColorDefault : styleConfig.uiColorDefaultDark
    }
    
    private var colorActive: Color {
        return styleLight ? styleConfig.uiColorActive : styleConfig.uiColorActiveDark
    }
    
    private var colorDisable: Color {
        return styleLight ? styleConfig.uiColorDisable : styleConfig.uiColorDisableDark
    }
    
    private var colorBgDefault: Color {
        return styleLight ? styleConfig.uiColorBgDefault : styleConfig.uiColorBgDefaultDark
    }
    
    private var colorBgActive: Color {
        return styleLight ? styleConfig.uiColorBgActive : styleConfig.uiColorBgActiveDark
    }
    
    private var colorBgDisable: Color {
        return styleLight ? styleConfig.uiColorBgDisable : styleConfig.uiColorBgDisableDark
    }
    
    private var colorTextDefault: Color {
        return styleLight ? styleConfig.uiColorText : styleConfig.uiColorTextDark
    }
    
    private var colorTextActive: Color {
        return styleLight ? styleConfig.uiColorTextActive : styleConfig.uiColorTextActiveDark
    }
    
    private var colorTextDisable: Color {
        return styleLight ? styleConfig.uiColorTextDisable : styleConfig.uiColorTextDisableDark
    }
    
    private var colorTextFielDefault: Color {
        return styleLight ? styleConfig.uiColorTextField : styleConfig.uiColorTextFieldDark
    }
    
    private var colorTextFielActive: Color {
        return styleLight ? styleConfig.uiColorTextFieldActive : styleConfig.uiColorTextFieldActiveDark
    }
    
    private var colorTextFielDisable: Color {
        return styleLight ? styleConfig.uiColorTextFieldDisable : styleConfig.uiColorTextFieldDisableDark
    }
    
    
    private var currentTextColor: Color {
        if dataAlert.isAlertMessage.wrappedValue {
            return colorAlert }
        if isDisabled { return colorTextDisable}
        if isFocused { return colorTextActive }
        if !text.isEmpty { return colorTextDefault }
        return colorTextDefault
    }
    
    private var currentTextFieldColor: Color {
        if dataAlert.isAlertMessage.wrappedValue {
            return colorTextFielActive }
        if isDisabled { return colorTextFielDisable}
        if isFocused { return colorTextFielActive }
        if !text.isEmpty { return colorTextFielDefault }
        return colorTextFielDefault
    }
    
    private var currentColor: Color {
        if dataAlert.isAlertMessage.wrappedValue {
            return colorBgDefault }
        if isDisabled { return colorBgDisable}
        if isFocused { return colorBgActive }
        if !text.isEmpty { return colorBgDefault }
        return colorBgDefault
    }
    
    private var currentBorderColor: Color {
        if dataAlert.isAlertMessage.wrappedValue {
            return colorAlert }
        if isDisabled { return colorDisable}
        if isFocused { return colorActive }
        if !text.isEmpty { return colorDefault }
        return colorDefault
    }
    
    private var colorAlert: Color {
        switch dataAlert.styleAlert.wrappedValue {
        case .sucsess:
            return Color.uiGrey800
        case .warning:
            return Color.uiOrange500
        case .error:
            return Color.uiRed500
        case .other:
            return Color.white
        }
    }
}


public struct EditConfig {
    public var uiColorDefault: Color
    public var uiColorDefaultDark: Color
    public var uiColorActive: Color
    public var uiColorActiveDark: Color
    public var uiColorDisable: Color
    public var uiColorDisableDark: Color
    public var uiColorBgDefault: Color
    public var uiColorBgDefaultDark: Color
    public var uiColorBgActive: Color
    public var uiColorBgActiveDark: Color
    public var uiColorBgDisable: Color
    public var uiColorBgDisableDark: Color
    public var uiColorText: Color
    public var uiColorTextActive: Color
    public var uiColorTextDisable: Color
    public var uiColorTextDark: Color
    public var uiColorTextActiveDark: Color
    public var uiColorTextDisableDark: Color
    public var uiColorTextField: Color
    public var uiColorTextFieldDark: Color
    public var uiColorTextFieldActive: Color
    public var uiColorTextFieldActiveDark: Color
    public var uiColorTextFieldDisable: Color
    public var uiColorTextFieldDisableDark: Color
    public var titleFont: Font
    public var editFont: Font
    public var uiRadius: CGFloat
    public var paddingHorizontal: CGFloat
    public var paddingVertical: CGFloat
    public var heigthEditMulti: CGFloat
    public var titleFontMulti: Font
    public var editFontMulti: Font
    public var uiRadiusMulti: CGFloat
    public var editFontMessage: Font
    public var editFontMessageMulti: Font
    
    public init(
        uiColorDefault: Color = .uiGrey800,
        uiColorDefaultDark: Color = .uiGrey800,
        uiColorActive: Color = .uiBlack,
        uiColorActiveDark: Color = .uiBlack,
        uiColorDisable: Color = .uiGrey400,
        uiColorDisableDark: Color = .uiGrey400,
        uiColorBgDefault: Color = .white,
        uiColorBgDefaultDark: Color = .white,
        uiColorBgActive: Color = .white,
        uiColorBgActiveDark: Color = .white,
        uiColorBgDisable: Color = .uiGrey100,
        uiColorBgDisableDark: Color = .uiGrey100,
        uiColorText: Color = .uiGrey800,
        uiColorTextActive: Color = .uiBlack,
        uiColorTextDisable: Color = .uiGrey400,
        uiColorTextDark: Color = .uiGrey800,
        uiColorTextActiveDark: Color = .uiBlack,
        uiColorTextDisableDark: Color = .uiGrey400,
        uiColorTextField: Color = .uiGrey800,
        uiColorTextFieldDark: Color = .uiGrey800,
        uiColorTextFieldActive: Color = .uiGrey800,
        uiColorTextFieldActiveDark: Color = .uiGrey800,
        uiColorTextFieldDisable: Color = .uiGrey400,
        uiColorTextFieldDisableDark: Color = .uiGrey400,
        titleFont: Font = .uiMontS16,
        editFont: Font = .uiMontM16,
        uiRadius: CGFloat = 24,
        paddingHorizontal: CGFloat = 16,
        paddingVertical: CGFloat = 12,
        heigthEditMulti: CGFloat = 112,
        titleFontMulti: Font = .uiMontS14,
        editFontMulti: Font = .uiMontM16,
        uiRadiusMulti: CGFloat = 16,
        editFontMessage: Font = .uiMontM14,
        editFontMessageMulti: Font  = .uiMontM14
    ) {
        self.uiColorDefault = uiColorDefault
        self.uiColorDefaultDark = uiColorDefaultDark
        self.uiColorActive = uiColorActive
        self.uiColorActiveDark = uiColorActiveDark
        self.uiColorDisable = uiColorDisable
        self.uiColorDisableDark = uiColorDisableDark
        self.uiColorBgDefault = uiColorBgDefault
        self.uiColorBgDefaultDark = uiColorBgDefaultDark
        self.uiColorBgActive = uiColorBgActive
        self.uiColorBgActiveDark = uiColorBgActiveDark
        self.uiColorBgDisable = uiColorBgDisable
        self.uiColorBgDisableDark = uiColorBgDisableDark
        self.uiColorText = uiColorText
        self.uiColorTextActive = uiColorTextActive
        self.uiColorTextDisable = uiColorTextDisable
        self.uiColorTextDark = uiColorTextDark
        self.uiColorTextActiveDark = uiColorTextActiveDark
        self.uiColorTextDisableDark = uiColorTextDisableDark
        self.uiColorTextField = uiColorTextField
        self.uiColorTextFieldDark = uiColorTextFieldDark
        self.uiColorTextFieldActive = uiColorTextFieldActive
        self.uiColorTextFieldActiveDark = uiColorTextFieldActiveDark
        self.uiColorTextFieldDisable = uiColorTextFieldDisable
        self.uiColorTextFieldDisableDark = uiColorTextFieldDisableDark
        self.titleFont = titleFont
        self.editFont = editFont
        self.uiRadius = uiRadius
        self.paddingHorizontal = paddingHorizontal
        self.paddingVertical = paddingVertical
        self.heigthEditMulti = heigthEditMulti
        self.titleFontMulti = titleFontMulti
        self.editFontMulti = editFontMulti
        self.uiRadiusMulti = uiRadiusMulti
        self.editFontMessage = editFontMessage
        self.editFontMessageMulti = editFontMessageMulti
    }
}


public struct DataAlert {
    public var textAlert: Binding<String> = .constant(uiEmpty)
    public var styleAlert: Binding<EditStyleAlert> = .constant(.error)
    public var isAlertMessage: Binding<Bool> = .constant(false)
    
    
    public init(
        textAlert: Binding<String> = .constant(uiEmpty),
        styleAlert: Binding<EditStyleAlert> = .constant(.error),
        isAlertMessage: Binding<Bool> = .constant(false)
    ) {
        self.textAlert = textAlert
        self.styleAlert = styleAlert
        self.isAlertMessage = isAlertMessage
        
    }
}

public struct EditModel {
    public var titleSee: Bool = true
    public var typeSecret: Bool = false
    public var addSpace : Int = 0
    public var nameIconStart: String = "ic_cm_eye"
    public var nameIconEnd: String = "ic_cm_eye"
    public var nameIconEndSure: String = "ic_cm_eye_see"
    public var iconColorDefault: Bool = false
    public var stylePresent: EditStylePresent
    
    public init(
        titleSee: Bool = true,
        typeSecret:Bool = false,
        addSpace : Int = 0,
        nameIconStart: String = "ic_cm_eye",
        nameIconEnd: String = "ic_cm_eye",
        nameIconEndSure: String = "ic_cm_eye_see",
        iconColorDefault: Bool = false,
        stylePresent: EditStylePresent = .NotIcon
    ) {
        self.titleSee = titleSee
        self.typeSecret = typeSecret
        self.addSpace = addSpace
        self.nameIconStart = nameIconStart
        self.nameIconEnd = nameIconEnd
        self.nameIconEndSure = nameIconEndSure
        self.iconColorDefault = iconColorDefault
        self.stylePresent = stylePresent
    }
}

public enum EditStylePresent: Hashable {
    case completeIcon
    case starIcon
    case endIcon
    case NotIcon
}

public enum EditStyleAlert: Hashable {
    case sucsess
    case warning
    case error
    case other
}

public enum FilterCaracter: Hashable {
    case alphaNUmeric
    case standar
    case cmDefault
}
