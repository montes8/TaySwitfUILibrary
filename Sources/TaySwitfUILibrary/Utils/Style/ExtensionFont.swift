//
//  ExtensionFont.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public extension Font {
    
    private static let montserratBold = "Montserrat-Bold"
    private static let montserratSemiBold = "Montserrat-SemiBold"
    private static let montserratMedium = "Montserrat-Medium"
    private static let montserratRegular = "Montserrat-Regular"
    private static let gabbi = "Gabi-Regular"
    private static let penny = "Penny-Regular"
    private static let flex = "Flex-Regular"
    private static let serif = "Serif-Regular"
    
    static var uiMontB40: Font { .custom(montserratBold, size: 40) }
    static var uiMontB35: Font { .custom(montserratBold, size: 35) }
    static var uiMontB25: Font { .custom(montserratBold, size: 25) }
    static var uiMontB22: Font { .custom(montserratBold, size: 22) }
    static var uiMontB20: Font { .custom(montserratBold, size: 20) }
    static var uiMontB18: Font { .custom(montserratBold, size: 18) }
    static var uiMontB16: Font { .custom(montserratBold, size: 16) }
    static var uiMontB14: Font { .custom(montserratBold, size: 14) }
    static var uiMontB12: Font { .custom(montserratBold, size: 12) }
    static var uiMontB10: Font { .custom(montserratBold, size: 10) }
    static var uiMontB8: Font { .custom(montserratBold, size: 8) }
    
    static var uiMontS40: Font { .custom(montserratSemiBold, size: 40) }
    static var uiMontS35: Font { .custom(montserratSemiBold, size: 35) }
    static var uiMontS25: Font { .custom(montserratSemiBold, size: 25) }
    static var uiMontS22: Font { .custom(montserratSemiBold, size: 22) }
    static var uiMontS20: Font { .custom(montserratSemiBold, size: 20) }
    static var uiMontS18: Font { .custom(montserratSemiBold, size: 18) }
    static var uiMontS16: Font { .custom(montserratSemiBold, size: 16) }
    static var uiMontS14: Font { .custom(montserratSemiBold, size: 14) }
    static var uiMontS12: Font { .custom(montserratSemiBold, size: 12) }
    static var uiMontS10: Font { .custom(montserratSemiBold, size: 10) }
    static var uiMontS8: Font { .custom(montserratSemiBold, size: 8) }
    
    static var uiMontM40: Font { .custom(montserratMedium, size: 40) }
    static var uiMontM35: Font { .custom(montserratMedium, size: 35) }
    static var uiMontM25: Font { .custom(montserratMedium, size: 25) }
    static var uiMontM22: Font { .custom(montserratMedium, size: 22) }
    static var uiMontM20: Font { .custom(montserratMedium, size: 20) }
    static var uiMontM18: Font { .custom(montserratMedium, size: 18) }
    static var uiMontM16: Font { .custom(montserratMedium, size: 16) }
    static var uiMontM14: Font { .custom(montserratMedium, size: 14) }
    static var uiMontM12: Font { .custom(montserratMedium, size: 12) }
    static var uiMontM10: Font { .custom(montserratMedium, size: 10) }
    static var uiMontM8: Font { .custom(montserratMedium, size: 8) }
    
    static var uiMontR40: Font { .custom(montserratRegular, size: 40) }
    static var uiMontR35: Font { .custom(montserratRegular, size: 35) }
    static var uiMontR25: Font { .custom(montserratRegular, size: 25) }
    static var uiMontR22: Font { .custom(montserratRegular, size: 22) }
    static var uiMontR20: Font { .custom(montserratRegular, size: 20) }
    static var uiMontR18: Font { .custom(montserratRegular, size: 18) }
    static var uiMontR16: Font { .custom(montserratRegular, size: 16) }
    static var uiMontR14: Font { .custom(montserratRegular, size: 14) }
    static var uiMontR12: Font { .custom(montserratRegular, size: 12) }
    static var uiMontR10: Font { .custom(montserratRegular, size: 10) }
    static var uiMontR8: Font { .custom(montserratRegular, size: 8) }
    
    static var uiGabbi40: Font { .custom(gabbi, size: 40) }
    static var uiGabbi35: Font { .custom(gabbi, size: 35) }
    static var uiGabbi25: Font { .custom(gabbi, size: 25) }
    static var uiGabbi22: Font { .custom(gabbi, size: 22) }
    static var uiGabbi20: Font { .custom(gabbi, size: 20) }
    static var uiGabbi18: Font { .custom(gabbi, size: 18) }
    static var uiGabbi16: Font { .custom(gabbi, size: 16) }
    static var uiGabbi14: Font { .custom(gabbi, size: 14) }
    static var uiGabbi12: Font { .custom(gabbi, size: 12) }
    static var uiGabbi10: Font { .custom(gabbi, size: 10) }
    static var uiGabbi8: Font { .custom(gabbi, size: 8) }
    
    static var uiPenny40: Font { .custom(penny, size: 40) }
    static var uiPenny35: Font { .custom(penny, size: 35) }
    static var uiPenny25: Font { .custom(penny, size: 25) }
    static var uiPenny22: Font { .custom(penny, size: 22) }
    static var uiPenny20: Font { .custom(penny, size: 20) }
    static var uiPenny18: Font { .custom(penny, size: 18) }
    static var uiPenny16: Font { .custom(penny, size: 16) }
    static var uiPenny14: Font { .custom(penny, size: 14) }
    static var uiPenny12: Font { .custom(penny, size: 12) }
    static var uiPenny10: Font { .custom(penny, size: 10) }
    static var uiPenny8: Font { .custom(penny, size: 8) }
    
    static var uiSerif40: Font { .custom(serif, size: 40) }
    static var uiSerif35: Font { .custom(serif, size: 35) }
    static var uiSerif25: Font { .custom(serif, size: 25) }
    static var uiSerif22: Font { .custom(serif, size: 22) }
    static var uiSerif20: Font { .custom(serif, size: 20) }
    static var uiSerif18: Font { .custom(serif, size: 18) }
    static var uiSerif16: Font { .custom(serif, size: 16) }
    static var uiSerif14: Font { .custom(serif, size: 14) }
    static var uiSerif12: Font { .custom(serif, size: 12) }
    static var uiSerif10: Font { .custom(serif, size: 10) }
    static var uiSerif8: Font { .custom(serif, size: 8) }
    
    static var uiF40: Font { .custom(flex, size: 40) }
    static var uiF35: Font { .custom(flex, size: 35) }
    static var uiF25: Font { .custom(flex, size: 25) }
    static var uiF22: Font { .custom(flex, size: 22) }
    static var uiF20: Font { .custom(flex, size: 20) }
    static var uiF18: Font { .custom(flex, size: 18) }
    static var uiF16: Font { .custom(flex, size: 16) }
    static var uiF14: Font { .custom(flex, size: 14) }
    static var uiF12: Font { .custom(flex, size: 12) }
    static var uiF10: Font { .custom(flex, size: 10) }
    static var uiF8: Font { .custom (flex, size: 8) }
}

public enum FontRegistry {
    public static func registerFonts() {
        let fontNames = [
            "Montserrat-Bold.ttf",
            "Montserrat-SemiBold.ttf",
            "Montserrat-Medium.ttf",
            "Montserrat-Regular.ttf",
            "Gabi-Regular",
            "Penny-Regular",
            "Flex-Regular",
            "Serif-Regular"
        ]
        
        for fontName in fontNames {
            guard let url = Bundle.module.url(forResource: fontName, withExtension: nil),
                  let fontDataProvider = CGDataProvider(url: url as CFURL),
                  let fontRef = CGFont(fontDataProvider) else {
                continue
            }
            
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterGraphicsFont(fontRef, &error)
        }
    }
}
