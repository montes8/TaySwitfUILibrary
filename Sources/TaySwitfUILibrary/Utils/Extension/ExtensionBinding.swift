//
//  ExtensionBinding.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 17/02/26.
//

import SwiftUI

public extension Binding{
    
    
    func cmToBool<T: Equatable & Sendable>(_ value: T) -> Binding<Bool> where Value == T? {
        Binding<Bool>(
            get: { self.wrappedValue == value },
            set: { newValue in
                if !newValue {
                    self.wrappedValue = nil
                }
            }
        )
    }
}
