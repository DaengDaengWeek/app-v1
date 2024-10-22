import SwiftUI

struct MedicalCardPopupView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isExpanded: Bool = false // 드롭다운 상태

    // 외부에서 아이콘과 폰트 설정 가능하도록 매개변수 추가
    var headerIcon: String = "creditcard.fill"
    var headerFont: Font = .headline
    var sectionFont: Font = .body

    var backgroundColor: Color = Color(UIColor.systemGroupedBackground)
    var borderColor: Color = Color.brown

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.white.opacity(0.4)
                .edgesIgnoringSafeArea(.all)

            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(borderColor, lineWidth: 2)
                    )
                    .padding(.horizontal, 20)

                VStack(spacing: 20) {
                    // 상단 제목과 이미지
                    HStack {
                        Spacer()
                        Image("Medicalcard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 40)
                        Spacer()
                    }
                    .padding(.top, 10)

                    // 건강검진 드롭다운 영역
                    VStack(spacing: 0) {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                isExpanded.toggle()
                            }
                        }) {
                            HStack {
                                Text("건강검진 2024.10.24")
                                    .font(.dw(.regular, size: 20))
                                Spacer()
                                HStack(spacing: 5) {
                                    Image(systemName: headerIcon)
                                        .foregroundColor(.yellow)
                                    Text("150,000원")
                                        .font(.dw(.regular, size: 20))
                                }
                                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 5)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(radius: 1)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                )
                        )
                        .padding(.horizontal, 20)

                        // 드롭다운된 내용 (흰색 배경)
                        if isExpanded {
                            VStack(alignment: .leading, spacing: 20) {
                                sectionHeader(
                                    title: "내원 이유",
                                    icon: "plus.circle.fill",
                                    iconColor: .green
                                ) {
                                    Text("입양 후 건강검진")
                                        .font(.dw(.regular, size: 20))
                                        .padding(.top, 5)
                                }
                                sectionHeader(
                                    title: "종합 소견",
                                    icon: "pencil.circle.fill",
                                    iconColor: .blue
                                ) {
                                    Text("양호합니다.\n앞으로 예방 접종에 신경써 주세요.")
                                        .font(.dw(.regular, size: 20))
                                        .padding(.top, 5)
                                }
                                sectionHeader(
                                    title: "검사 내역",
                                    icon: "flask.fill",
                                    iconColor: .red
                                ) {
                                    VStack(spacing: 5) {
                                        ForEach(["신체검사", "분변검사", "방사선 검사", "초음파 검사", "혈액검사"], id: \.self) { test in
                                            HStack {
                                                Text(test)
                                                    .font(.dw(.regular, size: 20))
                                                Spacer()
                                                Text("정상")
                                                    .foregroundColor(.green)
                                                    .font(.dw(.regular, size: 20))
                                            }
                                            .padding(.vertical, 5)
                                            Divider()
                                        }
                                    }
                                    .padding(.top, 5)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(radius: 1)
                            )
                            .padding(.horizontal, 20)
                        }
                    }

                    Spacer()

                    // 하단 고정 버튼들
                    HStack(spacing: 20) {
                        HStack(spacing: 5) {
                            Image("coinIcon")
                            Text("150,000원")
                                .font(.dw(.regular, size: 12))
                        }
                        Spacer()

                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("뒤로가기")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                        }

                        Button(action: {
                            print("결제하기 버튼 눌림")
                        }) {
                            Text("결제하기")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.brown)
                                .cornerRadius(10)
                        }
                    }
                    .padding([.horizontal, .bottom], 20)
                }
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    // 재사용 가능한 섹션 헤더 뷰
    @ViewBuilder
    private func sectionHeader<Content: View>(
        title: String,
        icon: String,
        iconColor: Color,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                Text(title)
                    .font(.headline)
                Spacer()
            }
            content()
        }
    }
}

// 미리보기 코드
#Preview {
    MedicalCardPopupView(
        headerIcon: "cart.fill", // 아이콘 변경 가능
        headerFont: .title2, // 폰트 변경 가능
        sectionFont: .body, // 섹션 폰트 변경 가능
        backgroundColor: Color.btnBeige,
        borderColor: Color.brown
    )
}
