//
//  BottomButtonView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/22/24.
//

import SwiftUI

struct BottomButtonView: View {
    
    let backgroundColor: Color
    var bigIconList: [String]
    var iconText: [String]
    //var smallIconList: [String]
    
    var showingFlag: Bool // 작은버튼 보여줄지 말지
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack { // 작은버튼 | 큰버튼
                HStack(spacing: 16) { // 작은버튼들
                    
                    SmallButtonView(
                        icon: bigIconList[0],
                        action: {}
//                        action: {
//                          increaseAffection() // 상호작용시 호감도
//                          togglePopup(for: "hygiene") // 위생관리 팝업 토글
//                        }
                    )
                    .hidden()
                    
                    SmallButtonView(
                        icon: bigIconList[1],
                        action: {}
                    )
                    .hidden()
                    
                    SmallButtonView(
                        icon: bigIconList[2],
                        action: {}
                    )
                    .hidden()
                    
                    SmallButtonView(
                        icon: bigIconList[3],
                        action: {}
                    )
                    .hidden()
                    
                }
                
                Spacer().frame(height: 15)
                
                HStack(spacing: 12) { // 큰버튼들
                    
                    BigButtonView(
                        icon: bigIconList[0],
                        text: iconText[0],
                        action: {}
//                        action: {
//                          increaseAffection() // 상호작용시 호감도
//                          togglePopup(for: "hygiene") // 위생관리 팝업 토글
//                        }
                    )
                    
                    BigButtonView(
                        icon: bigIconList[1],
                        text: iconText[1],
                        action: {}
                    )
                    
                    BigButtonView(
                        icon: bigIconList[2],
                        text: iconText[2],
                        action: {}
                    )
                    
                    BigButtonView(
                        icon: bigIconList[3],
                        text: iconText[3],
                        action: {}
                    )
                }
                
            }
            
        }
        .frame(height: 200)
        //.background(Color(hex: "#CAEEFC")) //영역 확인용 배경색
    }
}

#Preview {
    BottomButtonView(backgroundColor: .clear, bigIconList: ["treatmentIcon", "checkupIcon", "injectionIcon", "beautyIcon"], iconText: ["진료받기", "건강검진", "예방접종", "미용하기"], showingFlag: false)
}

struct BigButtonView: View {
    let icon: String
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                // 버튼 배경
                Color.btnBeige
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                // 아이콘과 텍스트
                VStack(spacing: -4) {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)

                    Text(text)
                        .font(.dw(.bold, size: 16))
                        .foregroundColor(.black)
                }

            }
            .frame(width: 84, height: 84)
            .overlay(
                RoundedRectangle(cornerRadius :10)
                    .stroke(Color.borderGray, lineWidth: 3)
                    .frame(width:82, height:82)
            )
        }

    }

}


struct SmallButtonView: View {
    let icon: String
    //let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                // 버튼 배경
                Color.btnBeige
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                // 아이콘과 텍스트
                VStack() {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 57, height: 57)

//                    Text(text)
//                        .font(.dw(.bold, size: 16))
//                        .foregroundColor(.black)
                }

            }
            .frame(width: 72, height: 72)
            .overlay(
                RoundedRectangle(cornerRadius :8)
                    .stroke(Color.borderGray, lineWidth: 2.5)
                    .frame(width:72, height:72)
            )
        }

    }

}
