//
//  ErrorMessageTextView.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 05.11.2023.
//

import SwiftUI

struct ErrorMessageTextView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .frame(height: 20)
            .padding(.vertical, 5)
            .font(.subheadline)
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//#Preview {
//    ErrorMessageTextView()
//}
