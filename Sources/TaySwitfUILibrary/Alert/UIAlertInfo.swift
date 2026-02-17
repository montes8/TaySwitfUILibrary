//
//  UIAlertInfo.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct CmAlertInfo: View {
    var title : String = uiEmpty
    var message: String = uiEmpty
    var titleGone : Bool = false
    var styleAlert: StyleAlert = StyleAlert.noneStyle
    var iShadow: Bool = true
    var isRadius: CGFloat = 20
    var isIconName: String = uiEmpty
    var isIconClose : Bool = false
    var isColorText : Color? = nil
    var actionDismiss: () -> Void = {}
    
    public init(title: String = uiEmpty,
                message: String = uiEmpty,
                titleGone : Bool = false,
                styleAlert: StyleAlert = StyleAlert.noneStyle,
                iShadow: Bool = false,
                isRadius: CGFloat = 20,
                isIconName: String = uiEmpty,
                isIconClose: Bool = false,
                isColorText: Color? = nil,
                actionDismiss: @escaping () -> Void = {}) {
        self.title = title
        self.message = message
        self.titleGone = titleGone
        self.styleAlert = styleAlert
        self.iShadow = iShadow
        self.isRadius = isRadius
        self.isIconName = isIconName
        self.isIconClose = isIconClose
        self.isColorText = isColorText
        self.actionDismiss = actionDismiss
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(uiName:isIconName)
                .resizable()
                .frame(width: 24,height: 24)
            VStack(alignment: .leading, spacing: 4) {
                if(!titleGone){
                    Text(title)
                        .font(.uiMontS14)
                        .foregroundColor(isColorText == nil ? getTextColorTitleAlert() : isColorText)
                    
                }
                Text(message)
                    .font(.uiMontM14)
                    .foregroundColor(isColorText == nil ? getTextColorTitleAlert() : isColorText)
            }
            if(isIconClose){
                Button(action: actionDismiss) {
                    Image(uiName: "ic_close")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .padding(6)
                       
                }.frame(width: 28,height: 28)
            }else{
                Spacer().frame(width: 16,height: 16)
            }
        }.padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: isRadius)
                    .fill(getBgColor())
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(getBorderColor(), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(iShadow ? 0.12 : 0), radius: iShadow ? 10 : 0, x: 0, y: iShadow ? 8 : 0)
                    .shadow(color: Color.black.opacity(iShadow ? 0.08 : 0), radius: 4, x: 0, y: iShadow ? 2 : 0)
         ).fixedSize(horizontal: false, vertical: true)
    }
    
    private func getBgColor()->Color{
        switch styleAlert{
        case .success:
            return Color.uiGreen100
        case .error:
            return Color.uiRed100
        case .warning:
            return Color.uiOrange100
        case .defaultStyle:
            return Color.uiBlue100
        default:
            return Color.white
        }
    }
    
    private func getBorderColor()->Color{
        switch styleAlert{
        case .success:
            return Color.uiGreen500
        case .error:
            return Color.uiRed500
        case .warning:
            return Color.uiOrange500
        case .defaultStyle:
            return Color.uiBlue300
        default:
            return Color.uiGrey300
        }
    }
    
    private func getIconAlert()->String{
        switch styleAlert{
        case .success:
            return "ic_success"
        case .error:
            return "ic_error"
        case .warning:
            return "ic_warning"
        default:
            return "ic_info"
        }
    }
    
    private func getTextColorTitleAlert()->Color{
        switch styleAlert{
        case .success:
            return Color.uiGrey900
        case .error:
            return Color.uiRed900
        case .warning:
            return Color.uiOrange900
        case .defaultStyle:
            return Color.uiBlue900
        default:
            return Color.uiGrey900
        }
    }
    
    private func getTextColorSubTitleAlert()->Color{
        switch styleAlert{
        case .success:
            return Color.uiGrey900
        case .error:
            return Color.uiRed900
        case .warning:
            return Color.uiOrange900
        case .defaultStyle:
            return Color.uiBlue900
        default:
            return Color.uiGrey900
        }
    }
}

public enum StyleAlert: Hashable {
    case success
    case error
    case warning
    case defaultStyle
    case noneStyle
}

struct AlertOverlayModifier: ViewModifier {
    @Binding var isPresented: Bool
    var cmMargin: CGFloat = 20
    var title : String = uiEmpty
    var message: String = uiEmpty
    var titleGone: Bool = false
    var styleAlert: StyleAlert = StyleAlert.noneStyle
    var iShadow: Bool = true
    var isRadius: CGFloat = 20
    var isIconName: String = uiEmpty
    var isIconClose : Bool = false
    var isColorText : Color? = nil
    var duration : CGFloat = 3.0
    var actionDismiss: () -> Void = {}
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                if isPresented{
                    CmAlertInfo(
                        title : title,
                        message: message,
                        titleGone:titleGone,
                        styleAlert: styleAlert,
                        iShadow: iShadow,
                        isRadius:  isRadius,
                        isIconName: isIconName,
                        isIconClose : isIconClose,
                        isColorText : isColorText,
                        actionDismiss: actionDismiss
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(.bottom, (-30) + cmMargin).padding(.horizontal,16)
                    .onAppear {
                        if duration > 0 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {isPresented = false}
                            }
                        }
                    }
                }
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isPresented)
    }
}


