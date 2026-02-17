//
//  UIImage.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

public struct UIImage: View {
    
    let nameImg: String
    var uiWidth : CGFloat
    var uiHeigth : CGFloat
    var uiTint : Color?
    var mHorizontal : CGFloat
    var mVertical : CGFloat
    var uiPosition : PositionImg
    var uiRotate : Double
    var action: () -> Void = {}
    
    public init(
        nameImg: String = uiEmpty,
        uiWidth : CGFloat = 24,
        uiHeigth : CGFloat = 24,
        uiTint : Color? = nil,
        mHorizontal : CGFloat = 0,
        mVertical : CGFloat = 0,
        uiPosition : PositionImg = PositionImg.none,
        uiRotate : Double = 0.0,
        action: @escaping () -> Void = {}
    ) {
        self.nameImg = nameImg
        self.uiWidth = uiWidth
        self.uiHeigth = uiHeigth
        self.uiTint = uiTint
        self.mHorizontal = mHorizontal
        self.mVertical = mVertical
        self.uiPosition = uiPosition
        self.uiRotate = uiRotate
        self.action = action
    }
    
    public var body: some View {
        HStack{
            if(validEnd()){
                Spacer()
            }
            VStack{
                if(validBottom()){
                    Spacer()
                }
                Image(uiName:nameImg)
                    .resizable()
                    .renderingMode(uiTint == nil ? .original : .template)
                    .foregroundColor(uiTint)
                    .rotationEffect(.degrees(uiRotate))
                    .frame(width: uiWidth, height: uiHeigth).onTapGesture {
                        action()
                    }
                if(validTop()){
                    Spacer()
                }
            }
            if(validStart()){
                Spacer()
            }
        }.padding(.top,validTop() ? mVertical:0).padding(.bottom,validBottom() ? mVertical:0).padding(.leading,validStart() ? mHorizontal: 0).padding(.trailing,validEnd() ? mHorizontal: 0).frame(maxWidth: .infinity,maxHeight: .infinity)
    }
    
    private func validTop()-> Bool{
        return uiPosition == .top ||  uiPosition == .startTop || uiPosition == .endTop
    }
    
    private func validBottom()-> Bool{
        return uiPosition == .bottom ||  uiPosition == .startBottom || uiPosition == .endBottom
    }
    
    
    private func validStart()-> Bool{
        return uiPosition == .start ||  uiPosition == .startTop || uiPosition == .startBottom
    }
    
    private func validEnd()-> Bool{
        return uiPosition == .end || uiPosition == .endBottom || uiPosition == .endTop
    }
}


public enum PositionImg: Hashable {
    case start
    case startTop
    case startBottom
    case end
    case endTop
    case endBottom
    case top
    case bottom
    case none
}
