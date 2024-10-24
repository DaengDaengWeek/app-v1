//
//  StateView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/22/24.
//

import SwiftUI

struct StateView: View {
    
    //전체 높이 200 고정
    
    @Binding var affectionLevel: Double // 애정도 상태를 부모 뷰와 공유
    @Binding var moneyAmount: Int
    @State private var currentTime: String = "" // 현재 시간을 저장
    
    let backgroundColor: Color // 배경색 설정
    var isHospital: Bool // 병원인지 체크 (진료카드 버튼 hidden 여부)
    let showEncyclo: () -> Void
    let popupProfile: () -> Void
    let showChart: () -> Void
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all) // 배경색을 전체 화면에 적용
            
            HStack { // 프로필, 마루, 호감도, 시간 | 돈 | 아이콘
                VStack { // 프로필, 마루, 호감도 | 시간 | 여백
                    HStack { // 프로필 | 마루, 호감도
                        Spacer().frame(width: 22) //24?
                        
                        Button(action: popupProfile) {
                            ZStack {
                                Circle()
                                    .fill(Color.btnBeige)
                                    .frame(width: 60, height: 60)
                                
                                Image("profileImg1") // 반려견 아이콘
                                    .resizable()
                                    .frame(width: 54, height: 54)
                            }
                            .padding(.top, 10)
                        }

                        
                        Spacer().frame(width: 8)
                        
                        VStack(alignment: .leading) { // 마루 | 호감도
                            //Spacer().frame(height: 12)
                            
                            Text("마루")
                                .font(.dw(.bold, size: 24))
                                .frame(width: 60, height: 28, alignment: .leading)
                                .padding(.top, 6)
                            
                            Spacer().frame(height: 4)
                            
                            ZStack(alignment: .leading) {
                                ProgressView(value: affectionLevel) // 애정도 프로그레스 바
                                    .frame(width: 57, height: 8)
                                    .scaleEffect(x: 1, y: 1.6, anchor: .center)
                                    .background(Color.progressBrown)
                                    .border(Color.outline, width: 1.2)
                                    .cornerRadius(8)
                                    .offset(x: 10, y: 0)
                                    .progressViewStyle(LinearProgressViewStyle(tint: Color.heartPink))
                                
                                Image("heartIcon") // 하트 아이콘
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            }
                        }
                        
                    }
                    
                    Spacer().frame(height: 16)
                    
                    Text(currentTime) // 현재 시간 표시
                        .font(.dw(.bold, size: 18))
                        .onAppear(perform: updateTime) // 뷰가 나타날 때 시간 업데이트 시작
                        .frame(width: 90, height: 40)
                        .cornerRadius(8)
                        .padding(.horizontal, 2)
                        .padding(.vertical, 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.borderGray, lineWidth: 3)
                                .fill(Color.borderGray.opacity(0.2))
                        )
                        .padding(.leading, 34)
                    
                    Spacer()
                }
                
                Spacer()
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .opacity(0)
                        .cornerRadius(10)
                        .frame(width: 90, height: 24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.borderGray, lineWidth: 2)
                                .fill(Color.borderGray.opacity(0.2))
                                .frame(width:90, height: 24)
                        )

                    
                    HStack {
                        Image("coinIcon")
                            .resizable()
                            .frame(width: 21, height: 21)
                            .padding(.leading, 10)

                        Spacer().frame(width: 4)

                        Text("250,000")
                            .font(.dw(.bold, size: 12))
                            .frame(width: 60, alignment: .leading)
                            .padding(.trailing, 10)
                    }
                    .frame(width: 90, height: 24)
                    .offset(x: 6, y: 0)
                }
                
                .padding(.top, 10)
                .padding(.bottom, 160)
            
                Spacer().frame(width: 20)
                
                VStack(spacing:10) {
                    Button(action:{}) {
                        Image("settingIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width:36, height:36)
                    }
                    
                    Button(action:{}) {
                        Image("bellIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width:36, height:36)
                    }
                    .padding(.bottom, 2)
                    
                    Button(action:{
                        showEncyclo()
                    }) {
                        Image("bookIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width:36, height:36)
                    }
                    .padding(.bottom, 2)
                    
                    Button(action: {
                        showChart()
                    }) {
                        Image("chartIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .opacity(isHospital ? 1 : 0)
                    }
                }
            }
            .padding(.trailing, 28)
        }
        .frame(height: 200)
    }
    
    func updateTime() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        currentTime = formatter.string(from: Date())
        
        Timer.scheduledTimer(withTimeInterval:1.0, repeats: true){ _ in
            currentTime = formatter.string(from: Date())
        }
    }
}

#Preview {
    StateView(affectionLevel:.constant(0.3), moneyAmount: .constant(0), backgroundColor:.clear, isHospital: false, showEncyclo: {}, popupProfile: {}, showChart: {})
}

