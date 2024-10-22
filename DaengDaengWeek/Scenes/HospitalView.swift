//
//  HospitalView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HospitalView: View {
    
    @State private var currentTime: String = ""
    @State private var affectionLevel: Double = 0.3
    @State private var showPopup: Bool = false
    @State private var feedingProgress: CGFloat = 1.0
    @State private var activePopup: String? = nil
    @State private var currentGif: String = "HospitalMotion.gif"
    @State private var goToHome = false
    
    let BigButtonList = ["treatmentIcon", "checkupIcon", "injectionIcon", "beautyIcon"]
    let BigButtonTextList = ["진료받기", "건강검진", "예방접종", "미용하기"]
    
    var body: some View {
        ZStack {
            if goToHome {
                MainView() // HomeView로 전환되면 나타나는 화면
                    .transition(.opacity) // Fade 애니메이션 적용
            } else {
                hospitalview
                    .transition(.opacity) // 병원 화면도 Fade 애니메이션 적용
            }
        }
        .animation(.easeInOut(duration: 0.5), value: goToHome) // 애니메이션 효과 적용
    }
    
    var hospitalview: some View {
        ZStack {
            Image("hospital_bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                StateView(affectionLevel: $affectionLevel, moneyAmount: .constant(250000), backgroundColor: .clear, isHospital: true)
                    .padding(.top, 50)
                    .padding(.trailing, -6)

                Spacer()
                
                AnimatedGifView(currentGif: $currentGif)
                    .frame(width: 253, height: 230)
                    .offset(x: 5, y: 22)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: goHome) { // goHome을 통해 HomeView로 전환
                        ZStack {
                            Circle()
                                .stroke(Color.borderGray, lineWidth: 4)
                                .fill(Color.btnBeige)
                                .frame(width: 68, height: 68)
                            Image("homeIcon")
                                .resizable()
                                .frame(width: 56, height: 56)
                        }
                    }
                    .padding(.trailing, 24)
                    .offset(x: 0, y: 72)
                }
                
                BottomButtonView(
                    affectionLevel: $affectionLevel,
                    currentGif: $currentGif,
                    performCheckup: { performCheckup() },
                    performFood: {}, 
                    showEnding: {}, 
                    goPark: {},
                    goHospital: {},
                    backgroundColor: .clear,
                    place: "hospital",
                    bigIconList: BigButtonList,
                    iconText: BigButtonTextList)
                    .padding(.bottom, 50)
            }
        }
    }
    
//    var body: some View {
//        ZStack {
//            Image("hospital_bg")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                
//                StateView(affectionLevel: $affectionLevel, moneyAmount: .constant(250000), backgroundColor: .clear, isHospital: true)
//                    .padding(.top, 50)
//                    .padding(.trailing, -6)
//
//                Spacer()
//                
//                AnimatedGifView(currentGif: $currentGif)
//                    .frame(width: 253, height: 230)
//                    .offset(x: 5, y: -16)
//                
//                Spacer()
//                
//                HStack {
//                    Spacer()
//                    
//                    Button(action: goHome) {
//                        ZStack {
//                            Circle()
//                                .stroke(Color.borderGray, lineWidth: 4)
//                                .fill(Color.btnBeige)
//                                .frame(width: 68, height: 68)
//                            Image("homeIcon")
//                                .resizable()
//                                .frame(width: 56, height: 56)
//                        }
//                    }
//                    .padding(.trailing, 24)
//                    .offset(x: 0, y: 72)
//                    
//                }
//                
//                BottomButtonView(
//                    affectionLevel: $affectionLevel,
//                    currentGif: $currentGif,
//                    performCheckup: {
//                        performCheckup()
//                    },
//                    performFood: {},
//                    backgroundColor: .clear,
//                    place: "hospital",
//                    bigIconList: BigButtonList,
//                    iconText: BigButtonTextList,
//                    showingFlag: false)
//                    .padding(.bottom, 50)
//            }
//        }
//        .statusBar(hidden: true)
//    }
    
    func performCheckup() {
        currentGif = "CheckupMotion.gif"
    }
    
    func goHome() {
        withAnimation {
            goToHome = true // fade 효과와 함께 HomeView로 전환
        }
    }
}

#Preview {
    HospitalView()
}


