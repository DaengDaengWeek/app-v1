//
//  PromiseView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/23/24.
//

import SwiftUI

struct PromiseView: View {
    
    let age: String = "3개월" // 고정된 나이 값
    let breeds = ["말티즈", "푸들"] // 선택 가능한 견종 목록
    let genders = ["남", "여"]
    
    var body: some View {
        ZStack {
            Color.btnBeige
            
            VStack { // 아래로 쭉
                
                // MARK: - 제목 | 닫기 버튼
                HStack {
                    Image("promiseTitle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 27)
                    
                    Spacer()
                    
                    Button(action: {
                        // 뷰 닫기 기능 제거
                    }) {
                        Image("closeBtn") // 닫기 버튼 이미지
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                }
                .padding(.horizontal)
                
                Spacer()

                // MARK: - 이름 입력 필드
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("이름")
                            .font(.dw(.regular, size: 20))
                        
                        Spacer()
                        
                        TextField("이름 입력", text: .constant(""))
                            .font(.dw(.bold, size: 20))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }
                    .padding(.horizontal, 70)
                    .padding(.bottom, 10)

                    // MARK: - 견종 선택 필드
                    HStack {
                        Text("견종")
                            .font(.dw(.regular, size: 20))
                        Spacer()
                        HStack(spacing: 6) {
                            // Static breed options, no selection logic
                            ForEach(breeds, id: \.self) { breedOption in
                                VStack(spacing: -20) {
                                    Image("sample_breed_image") // Replace with a static image name
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 95, height: 95)
                                    Text(breedOption)
                                        .font(.dw(.regular, size: 16))
                                        .foregroundColor(.black)
                                }
                                .frame(width: 100, height: 100)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .opacity(0.5) // Make all options semi-transparent
                            }
                        }
                        .frame(width: 200)
                    }
                    .padding(.horizontal, 70)
                    .padding(.top, 10)

                }

                // MARK: - 성별 선택 필드 (Static)
                HStack(alignment: .center) {
                    Text("성별")
                        .font(.dw(.regular, size: 20))
                        .frame(width: 60, alignment: .leading)

                    // Static gender options (No Picker)
                    HStack(spacing: 20) {
                        Text("남").font(.dw(.regular, size: 20))
                        Text("여").font(.dw(.regular, size: 20))
                    }
                }
                .padding(.horizontal, 70)
                .padding(.top, 10)

                // MARK: - 나이 표시 필드
                HStack(alignment: .center) {
                    Text("나이")
                        .font(.dw(.regular, size: 20))
                        .frame(width: 60, alignment: .leading)

                    Text(age)
                        .font(.dw(.bold, size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 70)
                .padding(.top, 10)

                Spacer()

                // MARK: - 서약 문구
                Text("위 반려견과 주인의 행복한 삶을 위하여 일주일 동안 열심히 000에 대해 알아가겠습니다.")
                    .font(.dw(.regular, size: 21))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)

                Spacer()

                // MARK: - 동의하기 버튼
                Button(action: {
                    // 동의하기 기능 제거
                }) {
                    Text("동의하기")
                        .font(.dw(.bold, size: 24))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 185, height: 54)
                        .background(Color.borderBeige)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.borderBeige, lineWidth: 3)
                        )
                }
                .padding(.bottom, 50)
            }
        }
        .frame(width: 325, height: 689)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.borderBeige, lineWidth: 4)
        )
    }
}

#Preview {
    PromiseView()
}
