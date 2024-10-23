//
//  AnimatedGifView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/23/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnimatedGifView: View {
    @Binding var currentGif: String
    
    // 내부 상태 변수
    @State private var gifOffsetX: CGFloat = 0
    @State private var gifOffsetY: CGFloat = 0
    @State private var gifSize: CGFloat = 230
    
    var body: some View {
        AnimatedImage(name: currentGif)
            .resizable()
            .scaledToFit()
            .frame(width: 253, height: gifSize)
            .offset(x: gifOffsetX, y: gifOffsetY)
            .onChange(of: currentGif) { newValue in
                if newValue == "CheckupMotion.gif" {
                    gifOffsetX = -24
                    gifOffsetY = -31
                    gifSize = 253
//                    withAnimation(.easeInOut(duration: 0.5)) {
//                        gifOffsetX = -10
//                        gifOffsetY = -10
//                        gifSize = 253
//                    }
                    
                    // 원상복구 후 GIF 변경
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                        gifOffsetX = 0
                        gifOffsetY = 0
                        gifSize = 230
                        currentGif = "HospitalMotion.gif"
                        
                    }
                }
                
                else if newValue == "FoodMotion.gif" {
//                    gifOffsetX = -24
//                    gifOffsetY = -31
                    gifSize = 253
//                    withAnimation(.easeInOut(duration: 0.5)) {
//                        gifOffsetX = -10
//                        gifOffsetY = -10
//                        gifSize = 253
//                    }
                    
                    // 원상복구 후 GIF 변경
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                        gifOffsetX = 0
//                        gifOffsetY = 0
//                        gifSize = 230
                        currentGif = "MainMotion2.gif"
                        
                    }
                }
            }
    }
}
