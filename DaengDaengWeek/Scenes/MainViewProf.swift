//
//  MainViewProf.swift
//  DaengDaengWeek
//
//  Created by 안준범 on 10/17/24.
//

import SwiftUI

struct MainViewProf: View {
    @Binding var affectionLevel: Double // 애정도 상태를 부모 뷰와 공유
    @State private var currentTime: String = "" // 현재 시간을 저장
    
    let backgroundColor: Color // 배경색 설정
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all) // 배경색을 전체 화면에 적용
            
            HStack {
                VStack {
                    HStack {
                        Image("DogIcon") // 반려견 아이콘
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(EdgeInsets(top: 0, leading: 27.3, bottom: 27.3, trailing: 8))
                        
                        VStack(alignment: .leading) {
                            Text("마루")
                                .font(.dw(.bold, size: 24)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                                .frame(width: 53, height: 28, alignment: .leading)
                            
                            ZStack(alignment: .leading) {
                                ProgressView(value: affectionLevel) // 애정도 프로그레스 바
                                    .frame(width: 57, height: 8)
                                    .scaleEffect(x: 1, y: 1.6, anchor: .center)
                                    .progressViewStyle(LinearProgressViewStyle(tint: Color.heartPink))
                                    .offset(x: -10, y: 0)
                                
                                Image("heartIcon") // 하트 아이콘
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .offset(x: -24, y: 0)
                            }
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 20.3, trailing: 8))
                        }
                        
                        Spacer()
                    }
                    
                    Text(currentTime) // 현재 시간 표시
                        .font(.dw(.bold, size: 18)) //폰트 적용 .font(.dw(.굵기, size: 폰트크기))
                        .onAppear(perform: updateTime) // 뷰가 나타날 때 시간 업데이트 시작
                        .frame(width: 80, height: 40)
                        .background(Color.gray.opacity(0.24))
                        .cornerRadius(8)
                        .padding(.horizontal, 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 3)
                        )
                        .padding(EdgeInsets(top:-10, leading:-30,bottom:20.3,trailing:8))
                }
                
                Spacer()
                
                Image("coinIcon") // 돈 아이콘
                    .padding(EdgeInsets(top:0, leading:0,bottom:100,trailing:20))
                
                Spacer()
                
                VStack(spacing:10) { // 설정 버튼들
                    Button(action:{}) {
                        Image("settingIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width:40,height:40)
                    }
                    
                    Button(action:{}) {
                        Image("bellIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width:40,height:40)
                    }
                    
                    Button(action:{}) {
                        Image("bookIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width:40,height:40)
                    }
                }
            }
            .padding()
            .foregroundColor(.black)
        }
    }
    
    func updateTime() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier:"ko_KR")
        formatter.dateFormat = "a hh:mm"
        currentTime = formatter.string(from: Date())
        
        Timer.scheduledTimer(withTimeInterval:1.0,repeats:true){ _ in
            currentTime = formatter.string(from: Date())
        }
    }
}

#Preview{
   MainViewProf(affectionLevel:.constant(0.3), backgroundColor:.clear)
}
