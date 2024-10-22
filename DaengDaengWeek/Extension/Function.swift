//
//  Function.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/23/24.
//

import SwiftUI

func increaseAffection(_ affectionLevel: inout Double, by amount: Double = 0.05) {
    affectionLevel = min(1.0, affectionLevel + amount)
}

func decreaseAffection(_ affectionLevel: inout Double, by amount: Double = 0.03) {
    affectionLevel = min(1.0, affectionLevel - amount)
}


// 건강검진 수행
//func performCheckup(_ currentGif: Binding<String>) {
//    currentGif.wrappedValue = "CheckupMotion.gif" // 먼저 CheckupMotion.gif로 변경
//    resetGif(to: currentGif, defaultGif: "HospitalMotion.gif", after: 4.5) // 4초 후 다시 원래 GIF로 변경
//}

//// gif를 일정시간 후에 초기화
//func resetGif(to gifName: Binding<String>, defaultGif: String, after delay: TimeInterval) {
//    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//        gifName.wrappedValue = defaultGif
//    }
//}

//func goToHospital() {
//    print("병원으로 이동 중...")
//}
