//
//  KeyCreateView.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 05.11.2023.
//

import SwiftUI

struct KeyCreateView: View {
    var keychainVM = KeychainViewModel()
    
    @State private var userName = ""
    @State private var pass = ""
    @State private var repeatPass = ""
    private var userErrorMessage = ""
    private var passErrorMessage = ""
    private var repeatPassErrorMessage = ""
        
    @Environment(\.dismiss) var dismiss
    @FocusState var isFocus: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().fill(.background)
                VStack {
                    TextField("User name", text: $userName)
                        .focused($isFocus)
                    ErrorMessageTextView(message: userErrorMessage)
                    SecureField("Key", text: $pass)
                        .focused($isFocus)
                    ErrorMessageTextView(message: passErrorMessage)
                    SecureField("Repeat key", text: $repeatPass)
                        .focused($isFocus)
                    ErrorMessageTextView(message: repeatPassErrorMessage)
                    CreateKeyButton(pass: $repeatPass, user: $userName)
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: { dismiss() }, label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
                        })
                    }
                }
            }.onTapGesture {
                isFocus = false
            }
        }
    }
}

struct CreateKeyButton: View {
    var keychainVM = KeychainViewModel()
    
    @Binding var pass: String
    @Binding var user: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            keychainVM.savePass(for: user, password: pass)
            dismiss()
        } label: {
            Text("Create Key")
                .frame(maxWidth: .infinity)
                .frame(height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
}






#Preview {
    KeyCreateView()
}
