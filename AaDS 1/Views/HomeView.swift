//
//  HomeView.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 05.11.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var storage = CloudStorage()
    @EnvironmentObject var AddPictureVM: AddPictureViewModel
    
    @State private var isShowingAddPictureSheet = false
    var columnGrid: [GridItem] = [GridItem(.flexible(), spacing: 1),
                                  GridItem(.flexible(), spacing: 1),
                                  GridItem(.flexible(), spacing: 1)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnGrid, spacing: 1) {
                ForEach(Array(storage.picturesDic.keys), id: \.self) { key in
                    Image(uiImage: storage.picturesDic[key]!)
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
                                let imageWithWatermark = storage.picturesDic[key]!.addWatermark()
                                storage.uploadPicture(image: imageWithWatermark, imageName: key)
                            }
                            Button(role: .destructive) {
                                storage.deletePicture(key)
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
        .sheet(isPresented: $isShowingAddPictureSheet) {  AddPictureView() }
        .onAppear {
            storage.downloadAllPictures()
        }
        .environmentObject(storage)
    }
}

#Preview {
    HomeView()
}














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
