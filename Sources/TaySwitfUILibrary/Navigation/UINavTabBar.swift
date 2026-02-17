//
//  UINavTabBar.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct UINavigationBotton: View {
    
    @Binding var selectedTab: Int
    @Binding var selectedEnableTab: Bool
    var tabs : [ UITabItem]
    var tayView : [AnyView]
    var styleConfig :  UINavBarConfig =  UINavBarConfig()
    
    public init(
        selectedTab: Binding<Int>,
        selectedEnableTab: Binding<Bool>,
        tabs: [ UITabItem],
        tayView: [AnyView],
        styleConfig :  UINavBarConfig = IniTaySwitUI.styleNavBarConfig
    ) {
        self._selectedTab = selectedTab
        self._selectedEnableTab = selectedEnableTab
        self.tabs = tabs
        self.tayView = tayView
    }
    
    public var body: some View {
        
        ZStack(alignment: .bottom) {
            UIViewContent(positionTab: $selectedTab,tayView:tayView)
            UICustomTabBar(positionTab: $selectedTab,selectedEnableTab: $selectedEnableTab,
                           styleConfig: styleConfig, tabs: tabs)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
}

struct  UIViewContent: View {
    @Binding var positionTab: Int
    var tayView : [AnyView]
    
    var body: some View {
        ZStack {
            ForEach(0..<tayView.count, id: \.self) { index in
                tayView[index]
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(positionTab == index ? 1 : 0)
                    .allowsHitTesting(positionTab == index)
            }
        }
    }
}


struct  UICustomTabBar: View {
    
    @Binding var positionTab: Int
    @Binding var selectedEnableTab: Bool
    var styleConfig :  UINavBarConfig
    let tabs: [ UITabItem]
    
    var body: some View {
        HStack(spacing: 0) {
            // ForEach(tabs, id: \.id) { (tab: TayTabItem) in por si el compilador no reconoce pasa aveces en xcode nuevos
            ForEach(tabs) {tab in
                VStack(spacing: styleConfig.marginTopIcon) {
                    Spacer().frame(height: 15)
                    Image(uiName: validIcon(position: positionTab, tab: tab))
                        .resizable()
                        .renderingMode(tab.iconNameActive.isEmpty ? .template : .original)
                        .foregroundColor(positionTab == tab.id ? styleConfig.iconColorActive : styleConfig.iconColorItem)
                        .frame(width: styleConfig.cmSizeIcon,height: styleConfig.cmSizeIcon)
                    
                    Text(tab.title)
                        .font(positionTab == tab.id ? styleConfig.textActiveFont : styleConfig.textFont)
                        .foregroundColor(positionTab == tab.id ? styleConfig.textColorActive : styleConfig.textColorItem)
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity, maxHeight: styleConfig.cmMaxHeigth)
                .contentShape(Rectangle())
                .onTapGesture {
                    if(selectedEnableTab){
                        positionTab = tab.id
                    }
                }
            }
        }
        .padding(.bottom, -15)
        .navigationBar(radius: styleConfig.radius,bgColor: styleConfig.bgColor)
    }
    
    private func validIcon(position : Int, tab :UITabItem )->String{
        if(positionTab == tab.id && !tab.iconNameActive.isEmpty){
            return tab.iconNameActive
        }else{
            return tab.iconName
        }
    }
}


public struct  UITabItem: Identifiable {
    public let id: Int
    public let iconName: String
    public let iconNameActive: String
    public let title: String
    
    public init(id: Int = 0, iconName: String = uiEmpty , iconNameActive: String = uiEmpty, title: String = uiEmpty) {
        self.id = id
        self.iconName = iconName
        self.iconNameActive = iconNameActive
        self.title = title
    }
}

public struct UINavBarConfig{
    var textFont : Font = Font.uiMontS10
    var textActiveFont : Font = Font.uiMontS10
    var textColorItem : Color = Color.uiGrey400
    var textColorActive : Color = Color.uiBlack
    var iconColorItem : Color = Color.uiGrey400
    var iconColorActive : Color = Color.uiBlack
    var bgColor : Color = Color.white
    var radius : CGFloat = 24
    var cmMaxHeigth : CGFloat = 52
    var cmSizeIcon : CGFloat = 20
    var marginTopIcon : CGFloat = 4
    
    init(textFont: Font  = Font.uiMontS10,
         textActiveFont: Font = Font.uiMontS10,
         textColorItem: Color = Color.uiGrey400,
         textColorActive: Color = Color.uiBlack,
         iconColorItem: Color = Color.uiGrey400,
         iconColorActive: Color = Color.uiBlack,
         bgColor: Color = Color.white,
         radius: CGFloat = 24,
         cmMaxHeigth : CGFloat = 52,
         cmSizeIcon : CGFloat = 20,
         marginTopIcon : CGFloat = 4) {
        self.textFont = textFont
        self.textActiveFont = textActiveFont
        self.textColorItem = textColorItem
        self.textColorActive = textColorActive
        self.iconColorItem = iconColorItem
        self.iconColorActive = iconColorActive
        self.bgColor = bgColor
        self.radius = radius
        self.cmMaxHeigth = cmMaxHeigth
        self.cmSizeIcon = cmSizeIcon
        self.marginTopIcon = marginTopIcon
    }
    
}

