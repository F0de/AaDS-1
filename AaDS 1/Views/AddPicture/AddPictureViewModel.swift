//
//  AddPictureViewModel.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 28.11.2023.
//

import Foundation
import UniformTypeIdentifiers

class AddPictureViewModel: ObservableObject {
    @Published var types: [UTType] = [.png]
}
