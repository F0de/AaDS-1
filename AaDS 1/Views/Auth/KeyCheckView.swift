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

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("User name", text: $userName)
                ErrorMessageTextView(message: userErrorMessage)
                SecureField("Key", text: $key)
                ErrorMessageTextView(message: keyErrorMessage)
                KeyCheckButton(pass: $key, user: $userName)
                    .padding(.bottom, 5)
                KeyCreateButton(isShowingKeyCreateSheet: $isShowingKeyCreateSheet)
                Spacer()
                TryDemoButton()
            }
            .padding()
            .sheet(isPresented: $isShowingKeyCreateSheet) { KeyCreateView() }
        }
        .environmentObject(AddPictureVM)
    }
}

struct KeyCheckButton: View {
    var keychainVM = KeychainViewModel()
    @EnvironmentObject var AddPictureVM: AddPictureViewModel

    @Binding var pass: String
    @Binding var user: String
    
    var body: some View {
        Button {
            AddPictureVM.types = keychainVM.checkPass(for: user, password: pass)
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

struct TryDemoButton: View {
    @EnvironmentObject var AddPictureVM: AddPictureViewModel

    var body: some View {
        NavigationLink {
            HomeView()
        } label: {
            Text("Try demo version")
                .frame(height: 30)
                .font(.title3)
        }
        .buttonStyle(.borderedProminent)
        .tint(.gray)
    }
}




#Preview {
    KeyCheckView()
}
