//
//  ExtensionUtil.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import Foundation
import SwiftUI

public extension String {
    
    func validCaracterEdit(_ type : CmFilterCaracter = .cmDefault)->String{
        switch(type){
        case .alphaNUmeric:
            return isValidAlphanumeri()
        case .cmDefault:
            return self
        case .standar:
            return isValidStandar()
        }
    }
    
    func isValidAlphanumeri() -> String {
        let allowed = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
        
        let filtered = self.filter { char in
            char.unicodeScalars.allSatisfy { allowed.contains($0) }
        }
        return filtered
    }
    
    
    func isValidStandar() -> String {
        let allowed = CharacterSet(charactersIn: "@.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
        
        let filtered = self.filter { char in
            char.unicodeScalars.allSatisfy { allowed.contains($0) }
        }
        return filtered
    }
    
    func cmSpannableText(customText: String,color: Color = Color.uiGrey700,
                         colorCustom: Color = Color.uiBlack, line :Bool = true
                         ,url : String = uiEmpty) -> AttributedString {
        var attributedString = AttributedString(self)
        attributedString.foregroundColor = color
        if let range = attributedString.range(of: customText) {
            attributedString[range].foregroundColor = colorCustom
            if(!url.isEmpty){
                attributedString[range].link = URL(string: url)
            }
            if(line){
                attributedString[range].underlineStyle = .single
            }
         
        }
        return attributedString
    }
    
    func formatNumberDecimal(range : Int = 2) -> String{
        var formatText = "00.00"
        if(!self.isEmpty){
            let textCurrent = self.removeSpaceAll()
            let text = textCurrent.replacingOccurrences(of: ",", with: "")
            let customLocale = Locale(identifier: "en_PE")
            let formatter = NumberFormatter()
            formatter.locale = customLocale
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = range
            formatter.maximumFractionDigits = range
            do{
                formatText = formatter.string(from: Double(text)! as NSNumber)!
            }
        }
        return formatText
    }
    
    func removeSpaceAll() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func formatAsterisk(count: Int = 4,countAsterisk: Int = 4,character : String = "*") -> String {
        if self.count > count {
            let rangeText = String(self.suffix(count))
            return String(repeating: character, count: countAsterisk) + rangeText
        } else {
            return  uiEmpty
        }
    }
    
    func converterAsterisk(flag : Bool,count :Int = 4,character : String = "*") -> String{
        if(flag){
            return self
        }else{
            return String(repeating: character, count:self.count)
        }
       
    }
}

public extension Int{
    
    func cmSizeText() -> CGFloat{
        return CGFloat(IniTaySwitUI .typeMovilSmall ? (self - 3) : self)
    }
    
    func cmSizeView() -> CGFloat{
        return CGFloat(IniTaySwitUI.typeMovilSmall ? (self - 10) : self)
    }
}

public extension CGFloat{
    
    func cmSizeText() -> CGFloat{
        return CGFloat(IniTaySwitUI.typeMovilSmall ? (self - 3) : self)
    }
    
    func cmSizeView() -> CGFloat{
        return CGFloat(IniTaySwitUI.typeMovilSmall ? (self - 10) : self)
    }
}
