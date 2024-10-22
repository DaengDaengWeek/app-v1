//
//  HospitalView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HospitalView: View {
    
    //.statusBar(hidden: true)
    
    @State private var currentTime: String = ""
    @State private var affectionLevel: Double = 0.3
    @State private var showPopup: Bool = false
    @State private var feedingProgress: CGFloat = 1.0
    @State private var activePopup: String? = nil
    
    let BigButtonList = ["treatmentIcon", "checkupIcon", "injectionIcon", "beautyIcon"]
    let BigButtonTextList = ["진료받기", "건강검진", "예방접종", "미용하기"]
    
    var body: some View {
        ZStack {
            Image("hospital_bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                StateView(affectionLevel: $affectionLevel, moneyAmount: .constant(2500000), backgroundColor: .clear, isHospital: true)
                    .padding(.top, 50)
                    .padding(.trailing, -6)

                Spacer()
                
                AnimatedImage(name: "HospitalMotion.gif")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 253, height: 230)
                    .offset(x: 5, y: -16)
              
                Spacer()
                
                BottomButtonView(backgroundColor: .clear, bigIconList: BigButtonList, iconText: BigButtonTextList, showingFlag: false)
                    .padding(.bottom, 50)
            }
        }
        .statusBar(hidden: true)
    }
    
}

#Preview {
    HospitalView()
}
