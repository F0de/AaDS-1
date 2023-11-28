//
//  KeychainViewModel.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 07.11.2023.
//

import SwiftUI
import Security
import UniformTypeIdentifiers

class KeychainViewModel {
    
    func savePass(for user: String, password: String) {
        let passwordData = password.utf8
        
        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: user,
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("Password saved to Keychain")
        } else {
            print("Error saving password to Keychain")
        }
    }
    
    func checkPass(for user: String, password: String) -> [UTType] {
        let passwordData = password.data(using: .utf8)

        let query: [String : Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: user,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                if passwordData == retrievedData {
                    print("Password matched! Unlocking premium features.")
                    return [.png, .jpeg]
                } else {
                    print("Incorrest password")
                }
            }
        } else if status == errSecItemNotFound {
            print("Password not found in Keychain")
        } else {
            print("Error retrieving password from Keychain")
        }
        return [.png]
    }
    
}
