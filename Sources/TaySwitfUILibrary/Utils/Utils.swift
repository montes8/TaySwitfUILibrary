//
//  Utils.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = [.topLeft, .topRight]
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct CustomNavigationConfig: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}

public class Utils{
    
    @MainActor public static func nextMovilSetting(){
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    @MainActor public static func nextSettingPricipal(){
        if let url = URL(string: "App-Prefs:root") {
                UIApplication.shared.open(url)
            }
    }
    
  
    @MainActor public static func sendEmail(){
        if let url = URL(string: "mailto:servicioalcliente@cajaarequipa.pe?subject=Caja%20Arequipa%20-%20Contacto") {
            UIApplication.shared.open(url)
        }
    }
    
    @MainActor public static func callNumber(phoneNumber: String = "080020222") {
        let cleanNumber = phoneNumber.filter { $0.isNumber }
        guard let url = URL(string: "tel://\(cleanNumber)"),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @MainActor public static  func redirectionSocial(number : String = numberWhatsapp,text :String = bodyTextWhatsapp){
            let appURL = URL(string: "whatsapp://send?phone=\(number)&text=\(text)")
            let appStoreURL = URL(string: "https://apps.apple.com/app/id310633997")
            if let url = appURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else if let storeURL = appStoreURL {
                UIApplication.shared.open(storeURL, options: [:], completionHandler: nil)
            }
    }
    
    public static func cmScaleImgSmall()->CGFloat{
        return CGFloat(IniTaySwitUI.typeMovilSmall ? 0.81 : 1)
    }
    
    @MainActor public static func goLinkWeb(url : String){
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}
