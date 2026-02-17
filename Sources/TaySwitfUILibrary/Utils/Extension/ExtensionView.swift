//
//  ExtensionView.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public extension View {
    
    func showTooltip(
        isPresented: Binding<Bool>,
        cmMessage: String = uiTest,
        positionX: CGFloat = 45,
        positionXCustom: Bool = false,
        position : Alignment = .topTrailing,
        mVertical: CGFloat = 8,
        mHorizontal: CGFloat = 0,
        duration: TimeInterval = 3.0
    ) -> some View {
        self.modifier(
            Toast(
                isPresented: isPresented,
                cmMessage: cmMessage,
                positionX: positionX,
                positionXCustom: positionXCustom,
                position : position,
                mVertical: mVertical,
                mHorizontal: mHorizontal,
                duration: duration
            )
        )
    }
    
    func generateDataKeyBoard(biometric : String = "") -> [String] {
        var numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        numbers.shuffle()
        var finalLayout = numbers
        finalLayout.insert(biometric, at: 9)
        finalLayout.append("delete")
        return finalLayout
    }
    
    func showToast(isPresented: Binding<Bool>,
                     cmMargin: CGFloat = 20,
                     title : String = uiTest,
                     message: String = uiTest,
                     titleGone: Bool = false,
                     styleAlert: StyleAlert = StyleAlert.noneStyle,
                     iShadow: Bool = true,
                     isRadius: CGFloat = 20,
                     isIconName: String = uiEmpty,
                     isIconClose : Bool = false,
                     isColorText : Color? = nil,
                     duration: TimeInterval = 3.0,
                     actionDismiss: @escaping () -> Void = {}
    ) -> some View {
        self.modifier(AlertOverlayModifier(
            isPresented: isPresented,
            title : title,
            message: message,
            titleGone : titleGone,
            styleAlert: styleAlert,
            iShadow: iShadow,
            isRadius:  isRadius,
            isIconName: isIconName,
            isIconClose : isIconClose,
            isColorText : isColorText,
            duration: duration,
            actionDismiss: actionDismiss
        )
        )
    }
    
    func showGenericDialog(
        isPresented: Binding<Bool>,
        title: String = uiTextErrorGeneric,
        subTitle: String = uiSubTextErrorGeneric,
        dialogStyle: DialogStyle = .defaultStyle,
        dModle: DialogModel = DialogModel(),
        styleConfig: DialogConfig = IniTaySwitUI.styleDialog,
        action: @escaping (Bool) -> Void = { _ in }
    ) -> some View {
        self.modifier(
            DialogModifier(
                isPresented: isPresented,
                title: title,
                subTitle: subTitle,
                dialogStyle: dialogStyle,
                dModle: dModle,
                styleConfig: styleConfig,
                action: action
            )
        )
    }
    
}

public extension View{
    @ViewBuilder
    func addToolbarKeyboard(textBtn : String = "Aceptar") -> some View {
        self.toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(textBtn) {
                        hideKeyboard()
                    }
                    .font(.uiMontS12)
                    .foregroundColor(.uiBlack)
                    .background(Color.uiGrey100).cornerRadius(16).padding(2)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @ViewBuilder
    func disableCopyPaste(_ active: Bool = true) -> some View {
        if active {
            self.highPriorityGesture(
                LongPressGesture(minimumDuration: 0.1)
                    .onEnded { _ in
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.warning)
                        print("Copiado/Pegado bloqueado")
                    }
            )
        } else {
            self
        }
    }
    
    func secureCapture(margin : CGFloat = -30) -> some View {
        return ScreenshotPreventView { self }
            .fixedSize(horizontal: false, vertical: false).padding(.vertical,margin)
    }
    
    var statusBarHeight: CGFloat {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first?.safeAreaInsets.top ?? 0
    }
    
    func navigationBar(radius : CGFloat = 24,bgColor : Color = .white)-> some View{
        self.background( RoundedRectangle(cornerRadius: radius).fill(bgColor)
            .shadow(color: .gray, radius: 5, x: 0, y: 5).ignoresSafeArea())
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func nextView(_ action: @escaping () -> Void) -> some View {
        Color.clear
            .frame(width: 0, height: 0)
            .onAppear(perform: action)
    }
    
    func bgRound(radius: CGFloat, bgColor: Color) -> some View {
        self
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: radius))
        
    }
    
    func bgStroker(radius: CGFloat, bgColor: Color,stroke: Color, lineWidth: CGFloat = 2) -> some View {
        self
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(stroke, lineWidth: lineWidth)
            )
    }
    
    func bgStrokerShadow(radius: CGFloat, bgColor: Color,stroke: Color, lineWidth: CGFloat = 2,cmY : CGFloat = 4) -> some View {
        self.background(
                        RoundedRectangle(cornerRadius: radius)
                            .fill(bgColor)
                            .shadow(color: Color.black.opacity(0.12), radius: radius, x: 0, y: cmY)
                            .shadow(color: Color.black.opacity(0.08), radius: radius, y: cmY)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: radius)
                            .stroke(stroke, lineWidth: lineWidth)
                    )
    }
    
    func hideToolbar() -> some View {
        self.modifier(CustomNavigationConfig())
    }
    
    var smallDevice: Bool {
        UIScreen.main.bounds.width < 390
    }
    
    @ViewBuilder
    func shimmer(isLoading: Bool,expansion:CGFloat = 0, radius: CGFloat = 4) -> some View {
        if isLoading {
            self.modifier(AnimationShimmer(cornerRadius: radius))
        } else {
            self
        }
    }
    
    func cmNavigate<Destination: View>(
            to destination: @escaping () -> Destination,
            when isActive: Binding<Bool>
        ) -> some View {
            self.navigationDestination(isPresented: isActive, destination: destination)
        }
}



public extension Image {
    init(uiName: String) {
        if let _ = UIImage(named: uiName, in: .module, with: nil) {
            self.init(uiName, bundle: .module)
        } else {
            self.init(uiName)
        }
    }
}

public extension Bundle {
    static var libraryTay: Bundle {
        return .module
    }
}



public extension Text{
    
    func uiCenter(line : Int = 2)->some View{
        self.lineLimit(line)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}


@MainActor public func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
