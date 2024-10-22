//
//  PromiseView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/23/24.
//

import SwiftUI

struct PromiseView: View {
    var body: some View {
        ZStack {
            Color.btnBeige
            
            VStack { // 아래로 쭉
                
                HStack { // 제목 | 닫기버튼
                    Image("promiseTitle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 27)
                    
                }
                
                
                
            }
            
            
        }
        .frame(width: 325, height: 689)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.borderBeige, lineWidth: 4)
        )
    }
}

#Preview {
    PromiseView()
}
