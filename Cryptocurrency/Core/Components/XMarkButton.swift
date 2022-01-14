//
//  XMarkButton.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import SwiftUI

struct XMarkButton: View {
            
    @Binding var showSheet: Bool
    
    var body: some View {
        Button {
            self.showSheet = false
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
        .foregroundColor(Color.theme.accent)
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton(showSheet: .constant(true))
            .preferredColorScheme(.dark)
    }
}
