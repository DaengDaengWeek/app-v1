//
//  EndingView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//

import SwiftUI

struct EndingView: View {
    
    let photoImgList = ["endingImg1", "endingImg2", "endingImg3"]
    let photoTextList = ["마루 삐졌다가 밥먹고 풀린 날", "열심히 걸었던 첫 산책날", "병원이라면 덜덜 떠는 마루"]
    let dateTextList = ["2024.10.24", "2024.10.24", "2024.10.26"]
    let textList = [
        "바빠서 밥을 늦게 준 날, 너는 배고파서\n사료 그릇을 뚫어져라 쳐다보고 있었지.\n밥 잘 먹고 풀려서 다행이었어.",
        "처음 산책할 때 내가 너무 빨리 걸었었지?\n헐떡거리면서 깡총깡총 열심히 걷는 모습에\n미안하면서도 귀엽더라고.",
        "건강검진 받으면서 덜덜 떨었지만, 끝까지 잘\n따라줘서 정말 고마웠어. 너도 나도\n긴장했지만, 잘해줘서 너무 대견했어!"
    ]
    
    @State private var idx = 0
    @State private var isFading = false // 화면 전체 페이드아웃 컨트롤
    @State private var isShowing = false // 텍스트 컨트롤
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if !isFading {
                VStack {
                    PolaroidView(photoImg: photoImgList[idx], photoText: photoTextList[idx], dateText: dateTextList[idx])
                        .padding(.top, 133)
                        .transition(.opacity)
                    
                    Spacer().frame(height: 27)
                    
                    Text(textList[idx])
                        .foregroundColor(.white)
                        .font(.dw(.light, size: 20))
                        .multilineTextAlignment(.center)
                        .lineSpacing(3)
                        .frame(width: 308, height: 90)
                        .opacity(isShowing ? 1 : 0)
                        .transition(.opacity)
                    
                    Spacer().frame(height: 154)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isShowing = true
                    }
                }
                
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        isFading = true
                    }
                    
                    withAnimation(.easeInOut(duration: 0.8)) {
                        isShowing = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        idx = (idx + 1) % photoImgList.count
                        
                        withAnimation(.easeInOut(duration: 0.8)) {
                            isFading = false
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation(.easeInOut(duration: 0.8)) {
                                isShowing = true
                            }
                        }
                    }
                }
            }
            
//            VStack {
//                PolaroidView(photoImg: photoImgList[idx], photoText: photoTextList[idx], dateText: dateTextList[idx])
//                    .padding(.top, 133)
//                
//                Spacer().frame(height: 27)
//                
//                Text(textList[idx])
//                    .foregroundColor(.white)
//                    .font(.dw(.light, size: 20))
//                    .multilineTextAlignment(.center)
//                    .lineSpacing(3)
//                    .frame(width: 308, height: 90)
//                
//                Spacer().frame(height: 154)
//            }

        }
    }
}

//#Preview {
//    EndingView()
//}


struct PolaroidView: View {
    var photoImg: String
    var photoText: String
    var dateText: String
    
    var body: some View {
        ZStack {
            Color(hex: "#F2F2F2")
            
            VStack {
                ZStack {
                    Color(hex: "#EBEBEB")
                    
                    Spacer()
                    
                    Image(photoImg)
                        .frame(width: 260, height: 342)
                        .padding(.top, 40)
                        .padding(.bottom, 25)
                }
                .frame(width: 310, height: 407)
                
                HStack {
                    Text(photoText)
                        .font(.dw(.regular, size: 24))
                        .frame(height: 28)
                        .padding(.leading, 25)
                    Spacer()
                }

                
                HStack {
                    Spacer()
                    Text(dateText)
                        .font(.dw(.light, size: 14))
                        .padding(.trailing, 14)
                        .frame(height: 13)
                }
                .padding(.bottom, 7)

            }

        }
        .frame(width: 310, height: 470)
    }
}
