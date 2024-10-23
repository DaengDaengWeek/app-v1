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
    
    var body: some View {
        ZStack{
            Image("encylopediabackground")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
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
                    
                    Button(action: {
                        // Tab 3 action
                    }) {
                        Image("Bookbtn3")
                    }
                    
                    Button(action: {
                        // Tab 4  action
                    }) {
                        Image("Bookbtn4")
                    }
                    
                    Spacer()
                }
                .frame(alignment:.leading)
                .padding(EdgeInsets(top:23, leading:50, bottom: 0, trailing: 0))
                
                VStack {
                    Button(action: {
                        print("Dismiss button pressed")
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 21, height: 21)
                    }
                    .padding(EdgeInsets(top:15, leading:282, bottom: -30, trailing: 0))
                    
                    HStack {
                        Image("bookicon")
                            .font(.largeTitle)
                            .padding(EdgeInsets(top:0, leading:28, bottom: 15, trailing: 0))
                        
                        ZStack {
                            // Border layer
                            Text("멍멍테니카 백과사전")
                                .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                .foregroundColor(Color.borderGray)
                                .padding(EdgeInsets(top:0, leading:0, bottom: 20, trailing: 54))
                                .overlay(
                                    Text("멍멍테니카 백과사전")
                                        .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                        .foregroundColor(Color.borderBeige) //Border color
                                        .offset(x:1, y:1)
                                        .padding(EdgeInsets(top:0, leading:0, bottom: 20, trailing: 54))
                                )
                            
                            //Foreground text
                            Text("멍멍테니카 백과사전")
                                .font(.dw(.light, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                .foregroundColor(.white) // Text Color
                                .padding(EdgeInsets(top:0, leading:0, bottom: 20, trailing: 54))
                        }
                        
                    }
                    .padding(EdgeInsets(top:20, leading:10, bottom: -15, trailing: 10))
                    
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
                        .stroke(Color.borderGray, lineWidth: 5))
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
                                    Image("feedstuff")
                                        .font(.largeTitle)
                                        .padding()
                                    Text("사료주기 • 1")
                                        .font(.dw(.bold, size: 14)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    Spacer()
                                }
                                Text("강아지는 성장 단계에 따라 하루에 사료를 주는 횟수가 달라집니다. 대부분의 경우 어릴 땐 하루 4~5회, 성견일 땐 2회 정도가 적당합니다.")
                                    .font(.dw(.light, size: 14)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                    .multilineTextAlignment(.leading)
                                    .padding(EdgeInsets(top:-15, leading:10, bottom: 5, trailing: 10))
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
    EncyclopediaView2()
}
