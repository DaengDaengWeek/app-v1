//
//  WalkView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//
import SwiftUI
import HealthKit
import SDWebImageSwiftUI

struct WalkView: View {
    @State private var showPopup = true
    @State private var steps: Int = 524
    @State private var exerciseTime: Int = 16
    @State private var progress: Double = 0.7
    @State private var backgroundOffset: CGFloat = -20
    @State private var animationDuration: Double = 3
    @State private var showMainView = false
    @State private var affectionLevel: Double = 0.3
    @State private var currentGif: String = "WalkMotion.gif"
    @State private var goToHome = false
    @State private var showEncylopediaView = false
    @State private var showProfileView = false
    
    @Environment(\.dismiss) var dismiss
    
    private let healthStore = HKHealthStore()
    
    var body: some View {  
        
        ZStack {
            if goToHome {
                MainView() // HomeView로 전환되면 나타나는 화면
                    .transition(.opacity) // Fade 애니메이션 적용
            } else {
                walkview
                    .transition(.opacity) // 병원 화면도 Fade 애니메이션 적용
            }
            
            if showEncylopediaView {
                Color.gray
                    .opacity(0.6)
                    .ignoresSafeArea()
                
                EncyclopediaView2(isPresented: $showEncylopediaView)
                    .transition(.scale)
                    .animation(.easeInOut(duration: 0.5), value: showEncylopediaView) // 애니메이션 적용
                
            }
            
            if showProfileView {
                Color.gray
                    .opacity(0.6)
                    .ignoresSafeArea()
                
                IdentityCardView(isPresented: $showProfileView)
                    .transition(.scale)
                    .animation(.easeInOut(duration: 0.5), value: showProfileView) // 애니메이션 적용
                
            }
        }
        .animation(.easeInOut(duration: 0.5), value: goToHome) // 애니메이션 효과 적용
//                
//                Image("dogwalkwithperson")
//                    .resizable()
//                    .frame(width: 35, height: 35)
//                    .offset(x: CGFloat(progress) * 325 - 150)
//                    .padding(EdgeInsets(top:-10, leading:0, bottom: 5, trailing: 0))
//                
//                
//                // Progress bar to show exercise progress
//                HStack {
//                    ProgressView(value: progress, total: 1.0)
//                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
//                        .frame(width: 325)
//                        .scaleEffect(x: 1, y: 2.5, anchor: .center)
//                }
//                .padding(.horizontal)
//                
//                // Display step count and exercise time
//                HStack {
//                    Spacer()
//                    Text("            \(steps)걸음")
//                    Spacer()
//                    Text("\(exerciseTime)분 / 30분")
//                }
//                .padding(.horizontal, 34)
//                .font(.dw(.bold, size: 16))
//                
//                Spacer()
//            }
//            
//            
//            // Popup view
//            if showPopup {
//                PopupView(showPopup: $showPopup)
//                    .padding(.horizontal, 20)
//            }
//        }
//        .onAppear(perform: fetchHealthData) // Automatically start fetching health data
    }
    
    var walkview: some View {
        ZStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    let imageWidth = UIImage(named: "walk_bg")?.size.width ?? geometry.size.width
                    Image("walk_bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageWidth, height: geometry.size.height)
                    Image("walk_bg") // Second copy of the background
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageWidth, height: geometry.size.height)
                }
                .offset(x: -backgroundOffset)
                .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: backgroundOffset)
                .onAppear {
                    // 이미지의 원본 너비를 얻고 스크롤 시작
                    let imageWidth = UIImage(named: "walk_bg")?.size.width ?? geometry.size.width
                    startScrolling(imageWidth)
                }
                .ignoresSafeArea()
            }
            
            VStack {
                
                StateView(affectionLevel: $affectionLevel, moneyAmount: .constant(250000), backgroundColor: .clear, isHospital: false, showEncyclo: { }, popupProfile: { }, showChart: {})
                    .padding(.top, 50)
                    .padding(.trailing, -6)

                Spacer().frame(height: 40)
                
                AnimatedImage(name: "WalkMotion.gif")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 200)
                    .offset(x: -100, y: 130)
                
                Spacer().frame(height: 10)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: goHome) { // goHome을 통해 HomeView로 전환
                            ZStack {
                                Circle()
                                    .stroke(Color.borderGray, lineWidth: 4)
                                    .fill(Color.btnBeige)
                                    .frame(width: 68, height: 68)
                                Image("homeIcon")
                                    .resizable()
                                    .frame(width: 56, height: 56)
                            }
                        }
                        .padding(.trailing, 24)
                        .offset(x: 0, y: 92)
                    }
                }
                .padding(.bottom, 40)
                
                Spacer().frame(height: 70)
                
                VStack {
                    Spacer()
                    
                    Image("walkingIcon")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .offset(x: CGFloat(progress) * 325 - 150)
                        .padding(.bottom, 4)
    //                    .padding(EdgeInsets(top:-10, leading:0, bottom: 5, trailing: 0))
                    
                    // Progress bar to show exercise progress
                    HStack {
                        ZStack {
                            ProgressView(value: progress, total: 1.0)
                                .frame(width: 325, height: 16)
                                //.progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "#70E188")))
                                .scaleEffect(x: 1, y: 2.5, anchor: .center)
                                .background(Color.progressBrown)
                                .cornerRadius(30)
                                .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "#70E188")))
                                .overlay( // Overlay the border with rounded corners
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.progressBrown, lineWidth: 3)
                                        .frame(width: 325, height: 14)
                                )
                        }

                    }
                    .padding(.horizontal)
                    
                    // Display step count and exercise time
                    HStack {
                        Spacer()
                        Text("            \(steps)걸음")
                            .foregroundColor(Color.outline)
                        Spacer()
                        Text("\(exerciseTime)분 / 30분")
                            .foregroundColor(Color.outline)
                    }
                    .padding(.horizontal, 34)
                    .font(.dw(.bold, size: 20))
                }
                .padding(.bottom, 40)
                
                Spacer().frame(height: 30)
            }
            
            if showPopup {
                PopupView(showPopup: $showPopup)
                    .padding(.horizontal, 20)
            }
            
        }
        .statusBar(hidden: true)
    }
    
    private func startScrolling(_ width: CGFloat) {
        // 애니메이션을 사용하여 배경을 원본 너비만큼 이동
        withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
            backgroundOffset = width-20
        }
    }
    
    func goHome() {
        withAnimation {
            goToHome = true // fade 효과와 함께 HomeView로 전환
        }
    }
    
    func showEncyclopedia() {
        withAnimation {
            showEncylopediaView = true
        }
    }
    
    func showProfile() {
        withAnimation {
            showProfileView = true
        }
    }
    
    func requestHealthData() {
        let typesToRead: Set = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!
        ]
        
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { success, error in
            if !success {
                // Handle error if authorization fails
            }
        }
    }
    
    func fetchHealthData() {
        requestHealthData() // Ensure authorization is requested
        
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let exerciseType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let stepQuery = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else { return }
            self.steps = Int(sum.doubleValue(for: HKUnit.count()))
            updateProgress()
        }
        
        let exerciseQuery = HKStatisticsQuery(quantityType: exerciseType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else { return }
            self.exerciseTime = Int(sum.doubleValue(for: HKUnit.minute()))
            updateProgress()
        }
        
        healthStore.execute(stepQuery)
        healthStore.execute(exerciseQuery)
    }
    
    func updateProgress() {
        self.progress = Double(self.exerciseTime) / 30.0
    }
}

struct PopupView: View {
    @Binding var showPopup: Bool
    
    var body: some View {

        VStack {
            HStack{
                Spacer()
                
                Button(action: { showPopup = false }) {
                    Image("closeBtn")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                .padding(.trailing, 10)
            }
            
            Text("걷기 시작하면 산책이 시작돼요.\n산책이 끝나면 집을 눌러주세요.\n함께 산책해 볼까요?")
                .font(.dw(.bold, size: 20))
                .lineSpacing(8)
                .multilineTextAlignment(.center)
                .offset(x: 0, y: -16)
            
        }
        .frame(height: 160)
        .background(Color.btnBeige)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(hex: "#99746C"), lineWidth: 2))
        .padding()
    }
}

// Preview provider for SwiftUI previews
#Preview {
    WalkView()
}
