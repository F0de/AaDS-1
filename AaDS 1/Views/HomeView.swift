//
//  HomeView.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 05.11.2023.
//

import SwiftUI
import Dispatch

struct HomeView: View {
    @ObservedObject var FBStorage: FirebaseStorage
    
    @State private var isShowingAddPictureSheet = false
    var columnGrid: [GridItem] = [GridItem(.flexible(), spacing: 1),
                                  GridItem(.flexible(), spacing: 1),
                                  GridItem(.flexible(), spacing: 1)]

    var body: some View {
        NavigationView {
//            List {
//                ForEach(Array(FBStorage.picturesDic.keys), id: \.self) { key in
//                    HStack {
//                        Image(uiImage: FBStorage.picturesDic[key]!)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 50, height: 50)
//                            .clipped()
//                        Text(key)
//                    }
//                    .onLongPressGesture {
//                        let generator = UIImpactFeedbackGenerator(style: .medium)
//                        generator.impactOccurred()
//                    }
//                    .contextMenu {
//                        Button("Add watermark") {
//                            //TODO: Adding watermark
//                        }
//                        Button(role: .destructive) {
//                                FBStorage.deletePicture(key)
//                        } label: {
//                            Text("Delete")
//                        }
//                    }
//                }
//            }
//            .listStyle(.plain)
//            .environment(\.defaultMinListRowHeight, 70)
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button { isShowingAddPictureSheet.toggle() }
//                label: { Image(systemName: "plus") }
//                }
//            }
//            .sheet(isPresented: $isShowingAddPictureSheet) {  AddPictureView(FBStorage: FBStorage) }
            ScrollView {
                LazyVGrid(columns: columnGrid, spacing: 1) {
                    ForEach(Array(FBStorage.picturesDic.keys), id: \.self) { key in
                        Image(uiImage: FBStorage.picturesDic[key]!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                            .clipped()
                            .onLongPressGesture {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                            }
                            .contextMenu {
                                Button("Add watermark") {
                                    //TODO: Adding watermark
                                }
                                Button(role: .destructive) {
                                    FBStorage.deletePicture(key)
                                } label: {
                                    Text("Delete")
                                }
                            }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { isShowingAddPictureSheet.toggle() }
                label: { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $isShowingAddPictureSheet) {  AddPictureView(FBStorage: FBStorage) }
        }
        .onAppear {
            FBStorage.downloadAllPictures()
        }
    }
}

#Preview {
    HomeView(FBStorage: FirebaseStorage())
}
