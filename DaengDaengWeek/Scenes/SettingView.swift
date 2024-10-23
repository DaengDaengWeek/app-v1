import SwiftUI

struct SettingView: View {
    // MARK: - 사용자 입력 속성
    @Binding var isPresented: Bool
    var onAgree: () -> Void
    
    @State private var name: String = ""              // 사용자 입력 이름
    @State private var breed: String = "푸들"           // 선택된 견종 (기본값: "푸들")
    @State private var gender: String = "남"            // 선택된 성별 (기본값: "남")
    @State private var isValidName: Bool = true        // 이름이 유효한지 여부를 나타내는 플래그

    // MARK: - 상수 속성
    let age: String = "3개월"                          // 고정된 나이 값
    let breeds = ["말티즈", "푸들"]                     // 선택 가능한 견종 목록
    let genders = ["남", "여"]                         // 선택 가능한 성별 목록

    // MARK: - 환경 변수
    @Environment(\.presentationMode) var presentationMode  // 뷰를 닫기 위해 사용되는 환경 변수

    // MARK: - 헬퍼 함수

    /// 주어진 이름의 UTF-8 인코딩 바이트 길이를 계산합니다.
    func nameByteLength(_ name: String) -> Int {
        return name.utf8.count
    }

    /// 이름이 유효한지 정규식을 사용하여 검사하고, 바이트 길이 제한을 확인합니다.
    func isNameValid(_ name: String) -> Bool {
        let byteLength = nameByteLength(name)
        let nameRegex = "^[ㄱ-ㅎ가-힣a-zA-Z0-9]*$"   // 한글, 영문자, 숫자만 허용
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: name) && byteLength >= 1 && byteLength <= 20
    }

    /// 선택된 견종에 해당하는 이미지 이름을 반환합니다.
    func breedImage(breed: String) -> String {
        switch breed {
        case "푸들": return "Sel 1"
        case "말티즈": return "Sel 2"
        default: return "default_image"
        }
    }

    // MARK: - 뷰 본문
    var body: some View {
        ZStack(alignment: .topTrailing) {

            // 메인 컨텐츠 컨테이너
            ZStack {
                // 테두리가 있는 라운드된 사각형 배경
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.outline, lineWidth: 5)
                    .background(Color.btnBeige)
                    .cornerRadius(20)
                    .padding(20)

                VStack(spacing: 20) {
                    // 헤더 이미지 표시
                    Image("Oath")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 50)
                        .padding(.top, 60)

                    Spacer()

                    // MARK: - 이름 입력 필드
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("이름")
                                .font(.dw(.regular, size: 20))
                            Spacer()
                            TextField("이름 입력", text: $name) { isEditing in
                                if !isEditing {
                                    // 편집이 끝났을 때 이름 유효성 검사
                                    isValidName = isNameValid(name)
                                    if !isValidName {
                                        // 이름이 유효하지 않을 경우 최대 바이트 길이에 맞게 자름
                                        name = String(name.prefix(while: { nameByteLength(String($0)) <= 20 }))
                                    }
                                }
                            }
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
                                ForEach(breeds, id: \.self) { breedOption in
                                    Button(action: {
                                        // 선택된 견종 업데이트
                                        breed = breedOption
                                    }) {
                                        VStack(spacing: -20) {
                                            Image(breedImage(breed: breedOption))
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
                                                .stroke(breed == breedOption ? Color.outline : Color.gray, lineWidth: 1)
                                        )
                                        .opacity(breed == breedOption ? 1.0 : 0.5) // 선택된 견종은 불투명하게 표시
                                    }
                                }
                            }
                            .frame(width: 200)
                        }
                        .padding(.horizontal, 70)
                        .padding(.top, 10)
                    }

                    // MARK: - 성별 선택 필드
                    HStack(alignment: .center) {
                        Text("성별")
                            .font(.dw(.regular, size: 20))
                            .frame(width: 60, alignment: .leading)

                        Picker(selection: $gender, label: Text(gender).foregroundColor(.black)) {
                            ForEach(genders, id: \.self) { genderOption in
                                Text(genderOption)
                                    .font(.dw(.regular, size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
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
                    Text("위 반려견과 주인의 행복한 삶을 위하여 일주일 동안 열심히 \(name.isEmpty ? "000" : name)에 대해 알아가겠습니다.")
                        .font(.dw(.regular, size: 21))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 20)

                    Spacer()

                    // MARK: - 동의하기 버튼
                    Button(action: {
                        // 진행하기 전에 이름 유효성 검사
//                        isValidName = isNameValid(name)
//                        if isValidName {
//                            print("동의하기 버튼 클릭됨")
//                            // 추가 동작을 여기에 추가
//                        }
                        isPresented = false // 설정 화면 닫기
                        onAgree()
                    }) {
                        Text("동의하기")
                            .font(.dw(.bold, size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 185, height: 54)
                            .background(Color.borderBeige)
                            .cornerRadius(10)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.borderBeige, lineWidth: 3)
                    )
                    .padding(.bottom, 50)
                }
            }

            // MARK: - 닫기 버튼 (이미지로 대체)
            Button(action: {
                // 뷰 닫기
                isPresented = false
            }) {
                Image("closeBtn") // 닫기 버튼 이미지
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50) // 이미지 크기 조정
                    .padding()
            }
            .padding(.top, 20)
            .padding(.trailing, 20)
        }
    }
}

#Preview {
    SettingView(isPresented: .constant(true), onAgree: {})
}
