//
//  IniTaySwitUI.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

public struct IniTaySwitUI:Sendable{
    public static let shared = IniTaySwitUI()
    nonisolated(unsafe) public static var styleKeyboardCode: KeyBoardConfig = KeyBoardConfig()
    nonisolated(unsafe) public static var styleDropdown: DropdownConfig = DropdownConfig()
    nonisolated(unsafe) public static var styleDropdownSmall: DropSmallModel = DropSmallModel()
    nonisolated(unsafe) public static var styleEdit: EditConfig = EditConfig()
    nonisolated(unsafe) public static var styleNavBarConfig: UINavBarConfig = UINavBarConfig()
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
