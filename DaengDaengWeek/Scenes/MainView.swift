import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
  
    // 현재 시간 표시를 위한 문자열 변수
    @State private var currentTime: String = ""
    // 애정도 (0.0 ~ 1.0 사이의 값)
    @State private var affectionLevel: Double = 0.3
    // 팝업 표시 여부
    @State private var showPopup: Bool = false
    // 먹이주기 진행도 (0.0 ~ 1.0 사이의 값)
    @State private var feedingProgress: CGFloat = 1.0
    // 활성화된 팝업의 종류 ("hygiene", "affection", "outing" 등)
    @State private var activePopup: String? = nil
    // 작은 아이콘 표시 여부 (먹이주기 버튼 클릭 시 나타남)
    @State private var showSmallIcons: Bool = false
    @State private var showPlaceIcons: Bool = false
    @State private var moneyAmounts: Int = 0
    @State private var currentGif: String = "MainMotion1.gif"
    @State private var isMainMotion1Active: Bool = true
    @State private var gifTimer: Timer?
    @State private var mainTimer: Timer?
    @State private var randomTimer: Timer?
    @State private var goToHospital: Bool = false
    @State private var goToPark: Bool = false
    @State private var showEndingPopup = false // 팝업 상태 관리
    @State private var showEncylopediaView = false

    // 먹이주기 지속 시간 (초)
    private let feedingDuration: TimeInterval = 30.0
    
    let BigButtonList = ["feedIcon", "hygienicsIcon", "affectionIcon", "outIcon"]
    let BigButtonTextList = ["먹이주기", "위생관리", "애정표현", "외출하기"]

    // 타이머 설정: 0.1초마다 갱신되는 타이머 (먹이주기 진행도 업데이트 등)
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    // 이미지 전환을 위한 타이머: 3초마다 이미지 변경
    let imageTimer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            if goToHospital {
                HospitalView()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5))
            }
            else if goToPark {
                WalkView()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5))
            }
            else {
                mainContent
                    .transition(.opacity)
            }
            
            if showEndingPopup {
                EndingPopupView()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 2.0))
            }
            
            if showEncylopediaView {
                Color(hex: "#D0BBBB")
                    .opacity(0.6)
                    .ignoresSafeArea()
                
                EncyclopediaView2(isPresented: $showEncylopediaView)
                    .transition(.scale)
                    .animation(.easeInOut(duration: 0.5), value: showEncylopediaView) // 애니메이션 적용
                
            }
        }
        .onAppear {
            startInitialGifCycle()
        }
        .onDisappear {
            stopGifCycles()
        }


        //                    // 외출하기 버튼
        //                    ButtonView(
        //                        icon: Image("outingbtn"),
        //                        text: "외출하기",
        //                        backgroundColor: iconBackgroundColor,
        //                        borderWidth: borderSize,
        //                        action: {
        //                            increaseAffection() // 상호작용시 호감도
        //                            togglePopup(for: "outing") // 외출하기 팝업 토글
        //                        }
        //                    )
        //                }
        //                .padding()
        //            }
        //            //         .onReceive(Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()) { _ in
        //            //             updateFeedingProgress()
        //            //         }
        //            // 타이머를 이용하여 먹이주기 진행도 업데이트
        //            .onReceive(timer) { _ in
        //                updateFeedingProgress()
        //            }
        //            // 타이머를 이용하여 이미지 전환
        //            .onReceive(imageTimer) { _ in
        //                cycleImages()
        //            }
        //        }
        //    }
    }
    
    private var mainContent: some View {
        ZStack {
            Image("main_bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                StateView(affectionLevel: $affectionLevel, moneyAmount: .constant(250000), backgroundColor: .clear, isHospital: false, showEncyclo: {
                    showEncyclopedia()
                })
                    .padding(.top, 50)
                    .padding(.trailing, -6)

                Spacer()
                
                AnimatedGifView(currentGif: $currentGif)
                    .frame(width: 253, height: 230)
                    .offset(x: 5, y: -16)
              
                Spacer()
                
                BottomButtonView(affectionLevel: $affectionLevel,
                                 currentGif: .constant(""),
                                 performCheckup: {},
                                 performFood: { performFood() },
                                 showEnding: { showEnding() },
                                 goPark: { goPark() },
                                 goHospital: { goHospital() },
                                 backgroundColor: .clear,
                                 place: "main",
                                 bigIconList: BigButtonList,
                                 iconText: BigButtonTextList)
                    .padding(.bottom, 50)
            }
        }
        .statusBar(hidden: true)
    }
    
    func startInitialGifCycle() {
        // 첫 번째 GIF는 MainMotion1으로 시작하고 2.5초 뒤 MainMotion2로 전환
        currentGif = "MainMotion1.gif"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            currentGif = "MainMotion2.gif"
            startRandomGifCycle()
        }
    }
    
    // 랜덤하게 MainMotion1을 가끔씩 재생하는 타이머 설정
    func startRandomGifCycle() {
        mainTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { _ in
            if !isMainMotion1Active {
                currentGif = "MainMotion2.gif"
            }
        }

        randomTimer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 15...60), repeats: true) { _ in
            if !isMainMotion1Active {
                playMainMotion1Randomly()
            }
        }
    }
    
    func playMainMotion1Randomly() {
        isMainMotion1Active = true
        currentGif = "MainMotion1.gif"
        
        // 2.5초 뒤에 다시 MainMotion2로 복귀
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            currentGif = "MainMotion2.gif"
            isMainMotion1Active = false
        }
    }

    // 타이머 멈추기
    func stopGifCycles() {
        mainTimer?.invalidate()
        randomTimer?.invalidate()
        mainTimer = nil
        randomTimer = nil
    }

    // 현재 시간 업데이트 함수
    func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        currentTime = formatter.string(from: Date())

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            currentTime = formatter.string(from: Date())
        }
    }
    
    func performFood() {
        currentGif = "FoodMotion.gif"
    }
    
    func showEnding() {
        //엔딩
        withAnimation {
            showEndingPopup = true
        }
        
    }
    
    func goHospital() {
        withAnimation {
            goToHospital = true 
        }
    }
    
    func goPark() {
        withAnimation {
            goToPark = true
        }
    }
    
    func showEncyclopedia() {
        withAnimation {
            showEncylopediaView = true
        }
    }
    
    // 먹이주기 진행도 업데이트 함수
    func updateFeedingProgress() {
        let decrement = CGFloat(0.1 / feedingDuration)
        feedingProgress = max(0.0, feedingProgress - decrement)
    }

    func increaseAffection() {
        affectionLevel = min(1.0, affectionLevel + 0.05) // Increase affection level up to a maximum of 1.0
    }
  
      // 먹이주기 진행도 초기화 함수
    func refillFeedingProgress() {
        feedingProgress = 1.0
    }

    // 팝업 표시 상태 토글 함수
    func togglePopup(for buttonType: String) {
        activePopup = activePopup == buttonType ? nil : buttonType
    }
}


// 먹이주기 버튼 뷰
struct FeedingButtonView: View {
    let icon: Image
    let text: String
    let progress: CGFloat // 먹이주기 진행도
    let backgroundColor: Color
    let borderWidth: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                // 버튼 배경
                backgroundColor
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                // 진행도 표시를 위한 오버레이
                VStack(spacing: 0) {
                    Spacer()
                    Rectangle()
                        .fill(Color.red.opacity(0.5))
                        .frame(height: 80 * progress)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                // 아이콘과 텍스트
                VStack(spacing: 1) {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width :50,height :50)

                    Text(text)
                        .font(.system(size :14,weight :.bold))
                        .foregroundColor(.black)

                }

            }.frame(width :80,height :80).overlay(RoundedRectangle(cornerRadius :10).stroke(Color.gray,lineWidth :5))
        }

    }

}

// 작은 아이콘 뷰
struct SmallIconView: View {
    let icon: Image
    let backgroundColor: Color
    let borderColor: Color
    let borderWidth: CGFloat

    var body: some View {
        VStack {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
        .frame(width: 60, height: 60)
        .background(backgroundColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: borderWidth)
        )
    }
}

#Preview {
   MainView()
}
