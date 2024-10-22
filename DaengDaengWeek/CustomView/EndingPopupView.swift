//
//  EndingPopupView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/23/24.
//

import SwiftUI

struct EndingPopupView: View {
    
    @State private var goToEnding = false
    
    var body: some View {
        
        ZStack {
            if goToEnding {
                EndingView()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 4.0))
            } else {
                popupview
                    .transition(.opacity)
            }
        }
//        .animation(.easeInOut(duration: 4.0), value: goToEnding)
 
    }
    
    var popupview: some View {
        ZStack {
            Color.btnBeige
            
            VStack { // 아래로 쭉
                
                Spacer().frame(height:36)
                
                Text("벌써 마루가 온 지 일주일이 됐어요.\n그간 있었던 추억을 돌아봐요.")
                    .font(.dw(.regular, size: 20))
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 30)
                
                Button(action: goEnding) {
                    ZStack {
                        // 버튼 배경
                        Color.outline
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        Text("엔딩보기")
                            .font(.dw(.bold, size: 20))
                            .foregroundColor(.white)

                    }
                    .frame(width: 142, height: 57)
                }
                
                Spacer().frame(height: 20)
            }
        }
        .frame(width: 311, height: 200)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.borderBeige, lineWidth: 2)
        )
    }
    
    func goEnding() {
        withAnimation(.easeInOut(duration: 4.0)) {
            goToEnding = true
        }
    }
}

#Preview {
    EndingPopupView()
}
