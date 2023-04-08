//
//  CircleButtonView.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 05.04.23.
//

import SwiftUI

struct CircleButtonView: View {
    
    
    let iconName: String
    
    var body: some View {
Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(Circle()
                .foregroundColor(Color.theme.background)
                        
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 10, y: 10)
        
        
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
            CircleButtonView(iconName: "heart.fill")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
    }}
