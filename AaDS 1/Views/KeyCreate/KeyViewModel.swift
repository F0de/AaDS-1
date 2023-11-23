//
//  KeyViewModel.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 07.11.2023.
//

import Foundation
//import CryptoSwift
//import CryptoKit
//import KeychainAccess
//
//class KeyViewModel: ObservableObject {
//    
//    
//    
//    func generateRandomKey() -> SymmetricKey {
//        return SymmetricKey(size: .bits256) // Можно выбрать другой размер ключа
//    }
//    
//    func createEncryption(pass: String) {
//        let userKey = pass // Введенный пользователем ключ
//        let randomKey = generateRandomKey() // Случайный ключ для шифрования
//        
//        do {
//            // Шифруйте пользовательский ключ с использованием случайного ключа
//            let encryptedKey = try CryptoUtils.encryptText(userKey, using: randomKey)
//            
//            // Сохраните зашифрованный ключ в Keychain
//            let keychain = Keychain(service: "com.your.app.keychain")
//            keychain["encryptedKey"] = encryptedKey.base64EncodedString()
//        } catch {
//            // Обработайте ошибку шифрования или сохранения в Keychain
//        }
//        
//    }
//}
