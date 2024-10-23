//
//  IdentityCardView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/24/24.
//

import SwiftUI

struct IdentityCardView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        
        ZStack {
            cardview
        }
//        .animation(.easeInOut(duration: 4.0), value: goToEnding)
 
    }
    
    var cardview: some View {
        ZStack {
            Image("identityCard")
                .resizable()
                .frame(width: 325, height: 206)
            
            HStack {
                Spacer()
                
                Button(action: {
                    isPresented = false
                }) {
                    Image("closeBtn")
                        .resizable()
                        .frame(width: 51, height: 51)
                }
                .offset(x: -35, y: -75)
            }
        }
    }
}

#Preview {
    IdentityCardView(isPresented: .constant(true))
}
