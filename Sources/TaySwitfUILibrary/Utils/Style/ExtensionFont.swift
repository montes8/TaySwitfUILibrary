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
    
    static var cmMontB64: Font { .custom(montserratBold, size: 64) }
    static var cmMontB48: Font { .custom(montserratBold, size: 48) }
    static var cmMontB35: Font { .custom(montserratBold, size: 35) }
    static var cmMontB25: Font { .custom(montserratBold, size: 25) }
    static var cmMontB20: Font { .custom(montserratBold, size: 20) }
    static var cmMontB16: Font { .custom(montserratBold, size: 16) }
    static var cmMontB14: Font { .custom(montserratBold, size: 14) }
    static var cmMontB12: Font { .custom(montserratBold, size: 12) }
    
    static var cmMontS25: Font { .custom(montserratSemiBold, size: 25) }
    static var cmMontS20: Font { .custom(montserratSemiBold, size: 20) }
    static var cmMontS18: Font { .custom(montserratSemiBold, size: 18) }
    static var cmMontS16: Font { .custom(montserratSemiBold, size: 16) }
    static var cmMontS14: Font { .custom(montserratSemiBold, size: 14) }
    static var cmMontS12: Font { .custom(montserratSemiBold, size: 12) }
    static var cmMontS10: Font { .custom(montserratSemiBold, size: 10) }
    
    static var cmMontM18: Font { .custom(montserratMedium, size: 18) }
    static var cmMontM16: Font { .custom(montserratMedium, size: 16) }
    static var cmMontM14: Font { .custom(montserratMedium, size: 14) }
    static var cmMontM12: Font { .custom(montserratMedium, size: 12) }
    static var cmMontM10: Font { .custom(montserratMedium, size: 10) }
    static var cmMontM8: Font { .custom(montserratMedium, size: 8) }
    
    static var cmMontR38: Font { .custom(montserratRegular, size: 38) }
    static var cmMontR25: Font { .custom(montserratRegular, size: 25) }
    static var cmMontR20: Font { .custom(montserratRegular, size: 20) }
    static var cmMontR18: Font { .custom(montserratRegular, size: 18) }
    static var cmMontR16: Font { .custom(montserratRegular, size: 16) }
    static var cmMontR14: Font { .custom(montserratRegular, size: 14) }
}

public enum FontRegistry {
    public static func registerFonts() {
        let fontNames = [
            "Montserrat-Bold.ttf",
            "Montserrat-SemiBold.ttf",
            "Montserrat-Medium.ttf",
            "Montserrat-Regular.ttf"
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
