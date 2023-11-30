//
//  KeyCheckView.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 05.11.2023.
//

import SwiftUI

struct KeyCheckView: View {
    @StateObject var AddPictureVM = AddPictureViewModel()
    var keychainVM = KeychainViewModel()
    
    @State private var userName = ""
    @State private var key = ""
    private var userErrorMessage = ""
    private var keyErrorMessage = ""

    @State private var isShowingKeyCreateSheet = false
    @State private var isShowingHomeView = false
    @FocusState var isFocus: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().fill(.background)
                VStack {
                    Spacer()
                    TextField("User name", text: $userName)
                        .focused($isFocus)
                    ErrorMessageTextView(message: userErrorMessage)
                    SecureField("Key", text: $key)
                        .focused($isFocus)
                    ErrorMessageTextView(message: keyErrorMessage)
                    KeyCheckButton(pass: $key, user: $userName)
                        .padding(.bottom, 5)
                    KeyCreateButton(isShowingKeyCreateSheet: $isShowingKeyCreateSheet)
                    Spacer()
                    NavigationLink(destination: HomeView()) {
                        TryDemoButton()
                    }.onTapGesture(perform: {
                        AddPictureVM.types = [.png]
                    })
                }
                .padding()
                .sheet(isPresented: $isShowingKeyCreateSheet) { KeyCreateView() }
            }.onTapGesture { isFocus = false }
        }
        .environmentObject(AddPictureVM)
    }
}

struct KeyCheckButton: View {
    var keychainVM = KeychainViewModel()
    @EnvironmentObject var AddPictureVM: AddPictureViewModel

    @Binding var pass: String
    @Binding var user: String

    @State private var shouldNavigate = false

    var body: some View {
        VStack {
            Button {
                (shouldNavigate, AddPictureVM.types) = keychainVM.checkPass(for: user, password: pass)
            } label: {
                Text("Check Key")
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
            }
            .buttonStyle(.borderedProminent)
            
            NavigationLink(destination: HomeView(), isActive: $shouldNavigate) {
                EmptyView()
            }.hidden()
        }
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

struct TryDemoButton: View {
    var body: some View {
        Text("Try demo version")
            .frame(height: 30)
            .font(.title3)
    }
}




#Preview {
    KeyCheckView()
}
