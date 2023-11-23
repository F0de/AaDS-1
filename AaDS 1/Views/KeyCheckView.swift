//
//  KeyCheckView.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 05.11.2023.
//

import SwiftUI

struct KeyCheckView: View {
    @State private var key = ""
    private var keyErrorMessage = ""

    @State private var isShowingKeyCreateSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                SecureField("Key", text: $key)
                ErrorMessageTextView(message: keyErrorMessage)
                KeyCheckButton()
                    .padding(.bottom, 5)
                KeyCreateButton(isShowingKeyCreateSheet: $isShowingKeyCreateSheet)
            }
            .padding()
            .sheet(isPresented: $isShowingKeyCreateSheet) { KeyCreateView() }
        }
    }
}

struct KeyCheckButton: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Check Key")
                .frame(maxWidth: .infinity)
                .frame(height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
}

struct KeyCreateButton: View {
    @Binding var isShowingKeyCreateSheet: Bool

    var body: some View {
        Button {
            isShowingKeyCreateSheet.toggle()
        } label: {
            Text("Create key if you don`t have")
                .font(.subheadline)
        }
    }
}






#Preview {
    KeyCheckView()
}
