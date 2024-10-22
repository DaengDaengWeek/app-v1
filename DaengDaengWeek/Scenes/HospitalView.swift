//
//  HospitalView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//

import SwiftUI

struct HospitalView: View {
    
    @State private var currentTime: String = ""
    @State private var affectionLevel: Double = 0.3
    @State private var showPopup: Bool = false
    @State private var feedingProgress: CGFloat = 1.0
    @State private var activePopup: String? = nil
    @State private var showSmallIcons: Bool = false
    
    var body: some View {
        ZStack {
            Image("hospital_bg") // 추후 배경 추가시 이름 변경
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                //MainViewProf(affectionLevel: $affectionLevel, backgroundColor: .white)
                //    .padding(EdgeInsets(top: -30, leading: 0, bottom: 100, trailing: 8))

                Spacer()

                // Center image area
                Image("Maindog1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 120)
              
                Spacer()
            }
        }
    }
}

#Preview {
    HospitalView()
}
