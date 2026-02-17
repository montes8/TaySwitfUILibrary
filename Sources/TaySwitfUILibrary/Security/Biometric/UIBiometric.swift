//
//  UIBiometric.swift
//  TaySwitfUILibrary
//
//  Created by Developer on 17/02/26.
//

import LocalAuthentication

public class CMBiometric{
    
    let context = LAContext()
    var errorNeo: NSError? = nil
    
    public init() {}
    
    var neoBiometryType: LABiometryType {
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &errorNeo) else {
            return .none
        }
        return context.biometryType
    }
    
    public func evaluateBiometryType() -> CMTypeBiometric{
        switch self.neoBiometryType {
        case .faceID:
            return CMTypeBiometric.faceId
        case .touchID:
            return CMTypeBiometric.touchID
        case .none:
            return CMTypeBiometric.notConfiguration
        default:
            return CMTypeBiometric.none
        }
    }
    
    public func evaluateBiometryIcon() -> String{
        switch self.neoBiometryType {
        case .faceID:
            return "faceid"
        case .touchID:
            return "fingerid"
        case .none:
            return "faceid"
        default:
            return uiEmpty
        }
    }
    
    public func evaluateFaceId() -> Bool {
        return  evaluateBiometryType() == .faceId
    }
    
    public func validBiometricEnable(value : CMTypeBiometric)->Bool{
        return value == CMTypeBiometric.faceId || value == CMTypeBiometric.touchID
    }
    
    
    public func validHadwareBiometric(value : CMTypeBiometric)->Bool{
        return value != CMTypeBiometric.none
    }
    
    public func showBiometricLogin(title : String = messagePermissionBiometric,completion: @escaping @MainActor @Sendable(CMValidateBiometric) -> Void) {
        
            guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &self.errorNeo) else {
                    Task { @MainActor in completion(.error) }
                    return
                }
            if hasBiometricDataChanged() {
                Task { @MainActor in completion(.change) }
                return
            }
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: title) { success, error in
                    DispatchQueue.main.async {
                        completion(success && error == nil ? .success : .error)
                    }
           }

    }
    
    
    public func showBiometric(title : String = messagePermissionBiometric,completion: @escaping @MainActor @Sendable(Bool) -> Void) {
        let contexto = LAContext()
        var error: NSError? = nil
        guard contexto.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
                Task { @MainActor in completion(false) }
                return
        }
        contexto.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: title) { success, error in
                DispatchQueue.main.async {
                    completion(success && error == nil)
                }
        }
    }
    
    func hasBiometricDataChanged() -> Bool {
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return false
        }
        
        guard let currentState = context.evaluatedPolicyDomainState else {
            return false
        }
        let currentStateData = currentState
        let storedStateData = loadFromKeychain()
        if let storedStateData = storedStateData {
            if storedStateData != currentStateData {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    public func saveToKeychain() {
        guard let data = context.evaluatedPolicyDomainState else {
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: IniTaySwitUI.namePackageApp,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    private func loadFromKeychain() -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String:  IniTaySwitUI.namePackageApp,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            return result as? Data
        } else {
            return nil
        }
    }
}


public enum CMTypeBiometric:Codable {
    case touchID
    case faceId
    case notConfiguration
    case none
}

public enum CMValidateBiometric:Codable,Sendable {
    case error
    case success
    case change
}
