import SwiftUI
import SDWebImageSwiftUI // AnimatedImage 사용을 위한 라이브러리

struct StartView: View {
    // 상태 변수 선언
    @State private var isSecondColor = false // 배경색 전환 플래그
    @State private var animationDuration = 2.0 // 애니메이션 시간(초)
    @State private var imagePadding: CGFloat = 100 // 상단 이미지 패딩
    @State private var showSecondGIF = false // 두 번째 GIF 표시 여부 플래그
    @State private var goToHome = false

    // 타이머 퍼블리셔 설정: isSecondColor 상태 변화를 감지
    let colorChangePublisher = Timer.publish(every: 0.1, on: .main, in: .default).autoconnect()

    var body: some View {
        ZStack {
            backgroundGradient // 배경 그라데이션
                .animation(.easeInOut(duration: animationDuration), value: isSecondColor)
                .edgesIgnoringSafeArea(.all)

            VStack {
                topImage // 상단 텍스트 이미지
                Spacer()

                gifImage // 조건에 따라 표시되는 GIF 이미지
                    .padding(.vertical, 20)

                Spacer()

                startButton // 시작 버튼
                    .padding(.bottom, 120)
            }
        }
        .onReceive(colorChangePublisher) { _ in
            handleColorChange() // 배경색 전환 처리
        }
    }

    // 배경 그라데이션 뷰
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                isSecondColor ? Color.startbackgroundYellow : Color.startbackgroundGray
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // 상단 텍스트 이미지 뷰
    private var topImage: some View {
        Image("maintext")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 100)
            .padding(.top, imagePadding)
    }

    // GIF 이미지 뷰 (조건에 따라 첫 번째 또는 두 번째 GIF 표시)
    private var gifImage: some View {
        let gifName = showSecondGIF ? "Mainsecond.gif" : "Mainfirst.gif"
        return AnimatedImage(name: gifName)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }

    // 시작 버튼 뷰
    private var startButton: some View {
        Button(action: startButtonTapped) {
            Text("시작하기")
                .font(.dw(.bold, size: 24))
                .foregroundColor(.black)
                .padding()
                .frame(width: 185, height: 54)
                .background(Color.startBeigebtn)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.borderGray, lineWidth: 3)
                )
        }
    }

    // 시작 버튼 클릭 처리
    private func startButtonTapped() {
        print("시작 버튼 클릭")
        withAnimation {
            isSecondColor.toggle() // 배경색 전환
        }
    }

    // 배경색 전환 처리: 전환 후 두 번째 GIF 표시
    private func handleColorChange() {
        if isSecondColor {
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                showSecondGIF = true
            }
        }
    }
}

// 미리 보기
#Preview {
    StartView()
}
