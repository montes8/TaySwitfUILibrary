//
//  IniTaySwitUI.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

public struct IniTaySwitUI:Sendable{
    public static let shared = IniTaySwitUI()
    nonisolated(unsafe) public static var styleButton: BtnConfig = BtnConfig()
    nonisolated(unsafe) public static var styleDialog: DialogConfig = DialogConfig()
    nonisolated(unsafe) public static var namePackageApp: String = uiEmpty
    nonisolated(unsafe) public static var typeMovilSmall: Bool = false

    
    public init() {}
    
    public static func initCMDefault(name : String = uiEmpty, setup: () -> Void = { }){
        namePackageApp = name
        FontRegistry.registerFonts()
        setup()
    }
}
