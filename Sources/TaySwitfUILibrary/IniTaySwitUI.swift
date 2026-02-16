//
//  IniTaySwitUI.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

public struct IniTaySwitUI:Sendable{
    public static let shared = IniTaySwitUI()
    
    nonisolated(unsafe) public static var namePackageApp: String = uiEmpty

    
    public init() {}
    
    public static func initCMDefault(name : String = uiEmpty, setup: () -> Void = { }){
        namePackageApp = name
        FontRegistry.registerFonts()
        setup()
    }
}
