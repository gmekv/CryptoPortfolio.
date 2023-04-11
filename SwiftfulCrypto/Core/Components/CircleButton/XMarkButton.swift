//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 10.04.23.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.isPresented) var presentationMode

    var body: some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })


    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
