//
//  BottomButtonView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/22/24.
//

import SwiftUI

struct BottomButtonView: View {
    
    @Binding var affectionLevel: Double
    @Binding var currentGif: String
    let performCheckup: () -> Void
    let performFood: () -> Void
    let showEnding: () -> Void
    let goPark: () -> Void
    let goHospital: () -> Void
    
    let backgroundColor: Color
    let place: String
    var bigIconList: [String]
    var iconText: [String]
    //var smallIconList: [String]
    
    //var showingFlag: Bool // 작은버튼 보여줄지 말지
    
    @State private var showSmallButtons = false
    @State var smallIconList = ["foodIcon", "waterIcon", "snackIcon", ""]
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack { // 작은버튼 | 큰버튼
                HStack(spacing: 16) { // 작은버튼들
                    
                    ForEach(0..<smallIconList.count, id: \.self) { index in
                        SmallButtonView(
                            icon: smallIconList[index],
                            action: {
                                if (index == 0) {
                                    increaseAffection(&affectionLevel)
                                    performFood()
                                }
                                
                                else if (index == 2) {
                                    if (smallIconList[2] == "parkIcon") {
                                        goPark()
                                    }
                                }
                                else if (index == 3) {
                                    if (smallIconList[3] == "hospitalIcon") {
                                        goHospital()
                                    }
                                }
                            }
                        )
                        // smallIconList가 비어 있는지 확인하고 opacity 설정
                        .opacity(showSmallButtons && !checkEmptyStr(smallIconList[index]) ? 1 : 0)
                    }
                
//                    SmallButtonView(
//                        icon: smallIconList[0],
//                        action: {
//                            increaseAffection(&affectionLevel)
//                            performFood()
//                        }
//                    )
//                    .opacity(showSmallButtons ? 1 : 0)
//                    
//                    SmallButtonView(
//                        icon: smallIconList[1],
//                        action: {}
//                    )
//                    .opacity(showSmallButtons ? 1 : 0)
//                    
//                    SmallButtonView(
//                        icon: smallIconList[2],
//                        action: {}
//                    )
//                    .opacity(showSmallButtons ? 1 : 0)
//                    
//                    SmallButtonView(
//                        icon: smallIconList[3],
//                        action: {}
//                    )
//                    .opacity(showSmallButtons ? 1 : 0)
                    
                }
                
                Spacer().frame(height: 15)
                
                HStack(spacing: 12) { // 큰버튼들
                    
                    BigButtonView(
                        affectionLevel: $affectionLevel, currentGif: $currentGif,
                        icon: bigIconList[0],
                        text: iconText[0],
                        action: {
                            if (place == "main") {
                                smallIconList[0] = "foodIcon"
                                smallIconList[1] = "waterIcon"
                                smallIconList[2] = "snackIcon"
                                smallIconList[3] = ""
                                showSmallButtons.toggle()
                            }
                            else if (place == "hospital") {
                                let _ = print("진료받기 수행")
                                increaseAffection(&affectionLevel)
                            }
                            
                        }
                    )
                    
                    BigButtonView(
                        affectionLevel: $affectionLevel, currentGif: $currentGif,
                        icon: bigIconList[1],
                        text: iconText[1],
                        action: {
                            //performCheckup($currentGif)
                            if (place == "hospital") {
                                performCheckup()
                            }
                            else if (place == "main") {
                                let _ = print("위생관리 수행")
                                showEnding()
                            }
                            increaseAffection(&affectionLevel)
                        }
                    )
                    
                    BigButtonView(
                        affectionLevel: $affectionLevel, currentGif: $currentGif,
                        icon: bigIconList[2],
                        text: iconText[2],
                        action: {}
                    )
                    
                    BigButtonView(
                        affectionLevel: $affectionLevel, currentGif: $currentGif,
                        icon: bigIconList[3],
                        text: iconText[3],
                        action: {
                            if (place == "main") {
                                smallIconList[0] = ""
                                smallIconList[1] = ""
                                smallIconList[2] = "parkIcon"
                                smallIconList[3] = "hospitalIcon"
                                showSmallButtons.toggle()
                            }
                        }
                    )
                }
                
            }
            
        }
        .frame(height: 200)
        //.background(Color(hex: "#CAEEFC")) //영역 확인용 배경색
    }
    
    func checkEmptyStr(_ str: String) -> Bool {
        return str.isEmpty
    }

}

#Preview {
    BottomButtonView(affectionLevel: .constant(0.3), 
                     currentGif: .constant(""),
                     performCheckup: {},
                     performFood: {},
                     showEnding: {}, 
                     goPark: {},
                     goHospital: {},
                     backgroundColor: .clear,
                     place: "hospital",
                     bigIconList: ["treatmentIcon", "checkupIcon", "injectionIcon", "beautyIcon"],
                     iconText: ["진료받기", "건강검진", "예방접종", "미용하기"])
}

struct BigButtonView: View {
    
    @Binding var affectionLevel: Double
    @Binding var currentGif: String
    
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
