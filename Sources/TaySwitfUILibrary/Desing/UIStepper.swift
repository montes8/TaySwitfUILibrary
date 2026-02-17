//
//  UIStepper.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 17/02/26.
//

import SwiftUI

enum StepState {
    case completed, active, pending
}

public struct CmStepperProgress: View {
    let steps: [String]
    let currentStep: Int
    var textVisible : Bool = false
    var circleSize: CGFloat = 28
    var styleConfig : StepperConfig = StepperConfig()
    
    public init(steps: [String], currentStep: Int) {
        self.steps = steps
        self.currentStep = currentStep
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(0..<steps.count, id: \.self) { index in
                    VStack(alignment: .center, spacing: 12) {
                        circleView(index: index + 1)
                        if(textVisible){
                            Text(steps[index])
                                .font(getTextFont(index: index))
                                .foregroundColor(getTextColor(index: index + 1))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                        }
                        
                    }
                    if index < steps.count - 1 {
                        Spacer(minLength: 0)
                    }
                }
            }
            progressLineView
        }
        .frame(maxWidth: .infinity)
    }
    
    private var progressLineView: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(styleConfig.progressColor)
                    .frame(height: 6)
                
                Capsule()
                    .fill(styleConfig.progressColorActive)
                    .frame(width: calculateProgressWidth(totalWidth: geo.size.width), height: 6)
            }
        }
        .frame(height: 6)
    }
    
    @ViewBuilder
    private func circleView(index: Int) -> some View {
        let isCompleted = index < currentStep
        let isCurrent = index == currentStep
        
        ZStack {
            if isCurrent {
                Circle()
                    .stroke(styleConfig.ColorCircleDefault, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [3]))
                    .frame(width: circleSize, height: circleSize)
                Text("\(index)").font(styleConfig.texFontCircleDefault).foregroundColor(styleConfig.textColorCircleDefault)
            } else if isCompleted {
                Circle()
                    .fill(styleConfig.colorCircleActive)
                    .frame(width: circleSize, height: circleSize)
                Text("\(index)").font(styleConfig.texFontCircleActive).foregroundColor(styleConfig.textColorCircleActive)
            } else {
                Circle()
                    .stroke(styleConfig.colorCircle, lineWidth: 1)
                    .frame(width: circleSize, height: circleSize)
                Text("\(index)").font(styleConfig.texFontCircle).foregroundColor(styleConfig.textColorCircle)
            }
        }
    }
    
    private func getTextColor(index: Int) -> Color {
        if index < currentStep { return styleConfig.textColorActive }
        if index == currentStep  { return styleConfig.textColorDefault }
        return styleConfig.textColor
    }
    
    private func getTextFont(index: Int) -> Font {
        if index < currentStep{ return styleConfig.texFontActive }
        if index == currentStep  { return styleConfig.texFontDefault }
        return styleConfig.texFont
    }
    
    
    private func updateCurrentStepProgress()->Int{
        return currentProgress
    }
    
    var currentProgress: Int {
        if currentStep == 1 {
            return 0
        } else if currentStep == (steps.count + 1) {
            return (currentStep * 4) + 1
        } else {
            return (currentStep * 4)
        }
    }
    
    
    private func calculateProgressWidth(totalWidth: CGFloat) -> CGFloat {
        let percentage = CGFloat(currentProgress - 1) / CGFloat(steps.count * 4)
        return totalWidth * max(0, min(percentage, 1))
    }
}


public struct StepperConfig{
    var progressColorActive : Color
    var progressColor : Color
    var textColorDefault : Color
    var textColorActive : Color
    var textColor : Color
    var textColorCircleDefault : Color
    var textColorCircleActive : Color
    var textColorCircle : Color
    var ColorCircleDefault : Color
    var colorCircleActive : Color
    var colorCircle : Color
    var texFontDefault :Font
    var texFontActive : Font
    var texFont : Font
    var texFontCircleDefault : Font
    var texFontCircleActive : Font
    var texFontCircle : Font
    
    public init( progressColorActive : Color = Color.uiBlack,
                 progressColor : Color = Color.uiGrey100,
                 textColorDefault : Color = Color.uiGrey800,
                 textColorActive : Color = Color.uiBlack,
                 textColor : Color = Color.uiGrey500,
                 textColorCircleDefault : Color = Color.uiGrey800,
                 textColorCircleActive : Color = Color.white,
                 textColorCircle : Color = Color.uiBlack,
                 ColorCircleDefault : Color = Color.uiBlack,
                 colorCircleActive : Color = Color.uiBlack,
                 colorCircle : Color = Color.uiGrey500,
                 texFontDefault :Font = Font.uiMontM14,
                 texFontActive : Font = Font.uiMontM14,
                 texFont : Font = Font.uiMontM14,
                 texFontCircleDefault : Font = Font.uiMontM14,
                 texFontCircleActive : Font = Font.uiMontM14,
                 texFontCircle : Font = Font.uiMontM14
    ) {
        self.progressColorActive = progressColorActive
        self.progressColor = progressColor
        self.textColorDefault = textColorDefault
        self.textColorActive = textColorActive
        self.textColor = textColor
        self.textColorCircleDefault = textColorCircleDefault
        self.textColorCircleActive = textColorCircleActive
        self.textColorCircle = textColorCircle
        self.ColorCircleDefault = ColorCircleDefault
        self.colorCircleActive = colorCircleActive
        self.colorCircle = colorCircle
        self.texFontDefault = texFontDefault
        self.texFontActive = texFontActive
        self.texFont = texFont
        self.texFontCircleDefault = texFontCircleDefault
        self.texFontCircleActive = texFontCircleActive
        self.texFontCircle = texFontCircle
    }
    
}
