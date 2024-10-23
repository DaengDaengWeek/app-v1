//
//  EncylopediaView2.swift
//  DaengDaengWeek
//
//  Created by 안준범 on 10/15/24.
//

import SwiftUI

struct EncyclopediaView2: View {
    @State var text : String = ""
    @State private var expandedSection: String? = nil
    @Environment(\.dismiss) var dismiss
    @State private var showEncycloPopup = false
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack{
            
            VStack {
                
                Spacer().frame(height: 60)
                
                // Custom tab bar
                HStack(spacing: 0) {
                    Button(action: {
                        // Tab 1 action
                    }) {
                        Image("Bookbtn1")
                        
                    }
                    
                    Button(action: {
                        // Tab 2 action
                    }) {
                        Image("Bookbtn2")
                    }
                    .offset(x: 0, y: 3)
                    
                    Button(action: {
                        // Tab 3 action
                    }) {
                        Image("Bookbtn3")
                    }
                    .offset(x: 0, y: 3)
                    
                    Button(action: {
                        // Tab 4  action
                    }) {
                        Image("Bookbtn4")
                    }
                    .offset(x: 0, y: 3)
                    
                    Spacer()
                }
                .frame(alignment:.leading)
                .padding(EdgeInsets(top:23, leading:50, bottom: 0, trailing: 0))
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
//                            print("Dismiss button pressed")
//                            dismiss()
                            isPresented = false
                        }) {
                            Image("closeBtn")
                                .resizable()
                                .frame(width: 51, height: 51)
                        }
                        .padding(EdgeInsets(top:6, leading:0, bottom: -30, trailing: 4))
                    }

                    
                    HStack {
                        Spacer()
                        
                        Image("encycloIcon")
                            .font(.largeTitle)
                            .frame(width: 46, height: 46)
                        
                        Spacer().frame(width: 2)
                        
                        ZStack {
                            Image("encycloTitle")
                                .resizable()
                                .frame(width: 190, height: 42)
                        }
                        Spacer()
                        
                    }
                    .padding(EdgeInsets(top:10, leading:10, bottom: 6, trailing: 10))
                    
                    HStack{
                        searchBarView(text:self.$text)
                    }
                    .padding(EdgeInsets(top:0, leading:40, bottom: -10, trailing: 40))
                    
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            SectionButton(title: "사료주기", isExpanded: expandedSection == "사료주기") {
                                toggleSection("사료주기")
                            }
                            
                            SectionButton(title: "물주기", isExpanded: expandedSection == "물주기") {
                                toggleSection("물주기")
                            }
                            
                            SectionButton(title: "간식주기", isExpanded: expandedSection == "간식주기") {
                                toggleSection("간식주기")
                            }
                        }
                        .padding()
                    }
                    .padding(EdgeInsets(top:0, leading:10, bottom: 0, trailing: 16))
                    
                    Spacer()
                }
                .background(Color(Color.btnBeige))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "#99746C"), lineWidth: 3))
                .padding(EdgeInsets(top:-15, leading:28, bottom: 177, trailing: 27))
            }
            .foregroundColor(Color.black)
        }
    }
        
    private func toggleSection(_ section: String) {
        if expandedSection == section {
            expandedSection = nil
        } else {
            expandedSection = section
        }
    }
}

struct SectionButton: View {
    let title: String
    let isExpanded: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                HStack {
                    Spacer()
                    
                    Text(title)
                        .font(.dw(.bold, size: 18)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                    
                    Spacer()
        
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
            .frame(width: 288, height:58)
            
            if isExpanded {
                if title == "사료주기" {
                    VStack(alignment:.leading) {
                        Button(action: {
                            // Tab 1 action
                        }) {
                            VStack{
                                HStack{
                                    Image("foodIcon")
                                        .resizable()
                                        .font(.largeTitle)
                                        .frame(width: 20, height: 20)

                                    Text("사료주기 • 1")
                                        .font(.dw(.bold, size: 14)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    Spacer()
                                }
                                .padding(.leading, 14)
                                .padding(.top, 18)
                                
                                Text("강아지는 성장 단계에 따라 하루에 사료를 주는 횟수가 달라집니다. 대부분의 경우 어릴 땐 하루 4~5회, 성견일 땐 2회 정도가 적당합니다.")
                                    .font(.dw(.light, size: 14)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    .multilineTextAlignment(.leading)
                                    .padding(EdgeInsets(top:0, leading:14, bottom: 5, trailing: 14))
                                Rectangle()
                                    .frame(width: 265, height:1)
                                    .background(Color.lineGray)
                                    .foregroundColor(Color.lineGray.opacity(0.4))
                                // No text styles in this selection
                                
                                                }
                        }
                        
                        Button(action: {
                            // Tab 2 action
                        }) {
                            VStack{
                                VStack{
                                    HStack{
                                        Image("lockicon")
                                            .padding()
                                        Text("사료주기 • 2")
                                            .font(.dw(.bold, size: 14)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    }
                                    .padding(EdgeInsets(top:-5, leading:0, bottom: -5, trailing: 150))
                                    Rectangle()
                                        .frame(width: 265, height:1)
                                        .background(Color.lineGray)
                                        .foregroundColor(Color.lineGray.opacity(0.4))
                                    
                                }
                                VStack{
                                    HStack{
                                        Image("lockicon")
                                            .padding()
                                        Text("사료주기 • 3")
                                            .font(.dw(.bold, size: 14)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    }
                                    .padding(EdgeInsets(top:-5, leading:0, bottom: -5, trailing: 150))
                                    Rectangle()
                                        .frame(width: 265, height:1)
                                        .background(Color.lineGray)
                                        .foregroundColor(Color.lineGray.opacity(0.4))
                                    
                                }
                                VStack{
                                    HStack{
                                        Image("lockicon")
                                            .padding()
                                        Text("사료주기 • 4")
                                            .font(.dw(.bold, size: 14)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    }
                                    .padding(EdgeInsets(top:-5, leading:0, bottom: -5, trailing: 150))
                                    Rectangle()
                                        .frame(width: 265, height:1)
                                        .background(Color.lineGray)
                                        .foregroundColor(Color.lineGray.opacity(0.4))
                                    
                                }
                            }
                        }
                        
                    }
                    .background(Color.white.opacity(0.9))
                    
                }
            }
        }
    }
}

    

#Preview {
    EncyclopediaView2(isPresented: .constant(true))
}
