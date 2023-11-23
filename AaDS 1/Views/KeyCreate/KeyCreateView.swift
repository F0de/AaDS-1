//
//  KeyCreateView.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 05.11.2023.
//

import SwiftUI

struct KeyCreateView: View {
    @State private var pass = ""
    @State private var repeatPass = ""
    private var passErrorMessage = ""
    private var repeatPassErrorMessage = ""
        
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                SecureField("Key", text: $pass)
                ErrorMessageTextView(message: passErrorMessage)
                SecureField("Repeat key", text: $repeatPass)
                ErrorMessageTextView(message: repeatPassErrorMessage)
                CreateKeyButton(pass: $repeatPass)
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
        }
    }
}

struct CreateKeyButton: View {
//    @ObservedObject var vm = KeyViewModel()
    
    @Binding var pass: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            
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
