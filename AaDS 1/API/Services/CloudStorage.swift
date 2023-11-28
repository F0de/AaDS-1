//
//  CloudStorage.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 08.11.2023.
//

import Firebase
import FirebaseStorage
import UIKit
import Dispatch

class CloudStorage: ObservableObject {
    @Published var picturesDic = [String : UIImage]()

    let storageRef = Storage.storage().reference()
    
    //MARK: Uploading picture file from iPhone file system to Firebase Storage and adding picture UIImage to picturesDic
    func uploadPicture(picURL: URL) -> Bool {
        var isError = false

        let concurrentQueue = DispatchQueue(label: "uploadPicture.concurrent-queue", qos: .utility, attributes: .concurrent)
        
        picURL.startAccessingSecurityScopedResource()

        // convert URL to Data
        do {
            let data = try Data(contentsOf: picURL)
            
            // upload picture data to FB Storage
            concurrentQueue.async {
                self.storageRef.child("pictures").child(picURL.lastPathComponent).putData(data) { result in
                    switch result {
                    case .success:
                        print("[FB Storage] File load to FB successfully")
                    case .failure(let error):
                        print("[FB Storage] Error loading file to FB: \(error.localizedDescription)")
                        isError = true
                    }
                }
            }
            
            // convert Data to UIImage
            if let uiImage = UIImage(data: data) {
                // add UIImage to picturesDic
                picturesDic[picURL.lastPathComponent] = uiImage
                print("picture (\(picURL.lastPathComponent)) append to picturesDic")
                print("picturesDic: \(picturesDic)")
            }
            print("Successfully read file data: \(data)")
        } catch {
            print("Error reading file \(error)")
        }
        
        picURL.stopAccessingSecurityScopedResource()
        
        return isError
    }
    
    //MARK: Uploading picture file from iPhone file system to Firebase Storage and adding picture UIImage to picturesDic
    func uploadPicture(image: UIImage, imageName: String) {
        let concurrentQueue = DispatchQueue(label: "uploadPicture.concurrent-queue", qos: .utility, attributes: .concurrent)
        
        // convert URL to Data
        if let data = try image.pngData() {
            
            // upload picture data to FB Storage
            concurrentQueue.async {
                self.storageRef.child("pictures").child(imageName).putData(data) { result in
                    switch result {
                    case .success:
                        print("[FB Storage] File load to FB successfully")
                    case .failure(let error):
                        print("[FB Storage] Error loading file to FB: \(error.localizedDescription)")
                    }
                }
            }
            
            // add UIImage to picturesDic
            picturesDic[imageName] = image
            print("picture (\(imageName)) replayced in picturesDic")
            print("picturesDic: \(picturesDic)")
            
            print("Successfully read file data: \(data)")
        }
        
    }
    
    //MARK: Deleting picture from Firebase Storage and picturesDic
    func deletePicture(_ pictureName: String) {
        let serialQueue = DispatchQueue(label: "deletingPicture.serial-queue", qos: .utility)
        // deleting picture from FB Storage
        serialQueue.sync {
            storageRef.child("pictures").child(pictureName).delete { error in
                if let error = error {
                    print("[FB Storage] Error deleting file. Error: \(error)")
                } else {
                    print("[FB Storage] File deleted successfully")
                }
            }
        }
        // deleting picture from picturesDic
        picturesDic.removeValue(forKey: pictureName)
        print("Deleted \(pictureName) from picturesDic")
        print("picturesDic: \(picturesDic)")
    }
    
    //MARK: Uploading all pictures from Firebase Storage to picturesDic
    func downloadAllPictures() {
        let concurrentQueue = DispatchQueue(label: "transferDownloadedPictures.concurrent-queue", qos: .utility, attributes: .concurrent)
        
        self.storageRef.child("pictures").listAll { result in
            switch result {
            case .success(let list):
                print("items count in FB: \(list.items.count)")
                for item in list.items {
                    concurrentQueue.async {
                        // download picture url from FB Storage
                        item.downloadURL { url, error in
                            guard let url = url, error == nil else {
                                print("[FB Storage] Failed to retrieve downloadURL: \(error)")
                                return
                            }
                            print("[FB Storage] Successfully download url: \(url.absoluteString)")
                            
                            // convert URL to Data
                            URLSession.shared.dataTask(with: url) { data, _, error in
                                guard let data = data, error == nil else {
                                    print("Data error \(error)")
                                    return
                                }
                                
                                // convert Data to UIImage
                                if let image = UIImage(data: data) {
                                    // add UIImage to picturesDic
                                    DispatchQueue.main.async() { [weak self] in
                                        guard let strongSelf = self else { return }
                                        strongSelf.picturesDic[url.lastPathComponent] = image
                                        print("picture (\(url.lastPathComponent)) append to array")
                                        print("picturesDic: \(strongSelf.picturesDic)")
                                    }
                                }
                            }.resume()
                        }
                    }
                }
            case .failure(let error):
                print("[FB Storage]", error)
            }
        }
    }
    
    //MARK: View file from iPhone file system
    func previewFile(picURL: URL) -> UIImage {
        var image = UIImage()
                
        picURL.startAccessingSecurityScopedResource()
        
        // convert URL to Data
        do {
            let data = try Data(contentsOf: picURL)
            
            // convert Data to UIImage
            if let uiImage = UIImage(data: data) {
                // image replacement
                image = uiImage
//                DispatchQueue.main.async { image = uiImage }
            }
            print("Successfully read file data: \(data)")
        } catch {
            print("Error reading file \(error)")
        }
        
        picURL.stopAccessingSecurityScopedResource()

        return image
    }
    
}
