//
//  Screen.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 16/02/26.
//

import SwiftUI

struct ScreenshotPreventView<Content: View>: UIViewRepresentable {
    let content: () -> Content
    
    func makeUIView(context: Context) -> UIView {
        let secureField = UITextField()
        secureField.isSecureTextEntry = true
        secureField.isUserInteractionEnabled = false
        guard let secureContainer = secureField.layer.sublayers?.first?.delegate as? UIView else {
            return UIView()
        }
        secureContainer.backgroundColor = .clear
        let hostingController = UIHostingController(rootView: content())
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        secureContainer.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: secureContainer.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: secureContainer.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: secureContainer.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: secureContainer.trailingAnchor)
        ])
        
        return secureContainer
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
}
