//
//  Color.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (without alpha)
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1) // Default to white in case of an error
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
    
    // 16진수 색상코드 가져와서 커스텀 컬러 지정
    static let borderGray = Color(hex: "#A3A09D")
    static let btnBeige = Color(hex: "#FAF5EB")
    static let backgroundBeige = Color(hex: "#F5F5F5")
    static let borderBeige = Color(hex: "#815C56")
    static let outline = Color(hex: "#815C56")
    static let heartPink = Color(hex: "FFA6EF")
    static let lineGray = Color(hex: "D9D9D9")
    static let btnPink = Color(hex:"F6E3E3")
    static let endingBeige = Color(hex: "#F0EADD")
}
