//
//  MedicalCardView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/24/24.
//

import SwiftUI

struct MedicalCardView: View {
    
    @Binding var isPresented: Bool
    @Binding var moneyAmount: Int
    
    var body: some View {
        
        ZStack {
            cardview
        }
//        .animation(.easeInOut(duration: 4.0), value: goToEnding)
 
    }
    
    var cardview: some View {
        ZStack {
            Image("medicalCard")
                .resizable()
                .frame(width: 325, height: 689)
            
            HStack {
                Spacer()
                
                VStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image("closeBtn")
                            .resizable()
                            .frame(width: 51, height: 51)
                    }
                    .offset(x: 5, y: 80)
                    
                    Spacer()
                    
                    Button(action: {
                        moneyAmount -= 150000 // Deduct 150000 when tempBtn is pressed
                        isPresented = false
                    }) {
                        Image("tempBtn")
                            .resizable()
                            .frame(width: 142, height: 57)
                            .offset(x: -120, y: -90)
                    }
                }

            }
        }
    }
}

#Preview {
    MedicalCardView(isPresented: .constant(true), moneyAmount: .constant(250000))
}
