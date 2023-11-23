//
//  AddPictureView.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 08.11.2023.
//

import SwiftUI

struct AddPictureView: View {
    @ObservedObject var FBStorage: FirebaseStorage

    @State private var fileURL: URL?
    @State private var fileName: String?
    @State private var image: UIImage?
    
    @Environment(\.dismiss) var dismiss
    @State private var showFileImporter = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: image ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: (UIScreen.main.bounds.width / 1.5) - 1, height: (UIScreen.main.bounds.width / 1.5) - 1)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 50)
                Text(fileName ?? "")
                    .padding(.top, 15)
                Spacer()
                Button {
                    showFileImporter.toggle()
                } label: {
                    HStack {
                        Image(systemName: "folder.badge.plus")
                        Text("Choose file")
                    }
                    .frame(maxHeight: 40)
                }
                .buttonStyle(.bordered)
                .padding(.bottom, 20)
                .tint(.blue)
                Button {
                    if let fileURL = fileURL {
                        print("Selected file to uploading: \(fileURL.lastPathComponent)")
                        showingAlert = FBStorage.uploadPicture(picURL: fileURL)
                    } else {
                        showingAlert.toggle()
                    }
                    
                    dismiss()
                } label: {
                    Text("Create")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 100)
                .tint(.green)
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
            .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.png]) { result in
                switch result {
                case .success(let url):
                    print("[fileImporter] File loaded. URL: \(url)")
                    fileURL = url
                    image = FBStorage.previewFile(picURL: url)
                    fileName = url.lastPathComponent
                case .failure(let error):
                    print("[fileImporter] Error while selecting a file. Error: \(error.localizedDescription)")
                }
            }
            .alert("Error, file not loaded.", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { dismiss() }
            }
        }
    }
}
