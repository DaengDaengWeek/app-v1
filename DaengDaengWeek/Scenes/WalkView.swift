//
//  WalkView.swift
//  DaengDaengWeek
//
//  Created by Jini on 10/15/24.
//
import SwiftUI
import HealthKit

struct WalkView: View {
    @State private var showPopup = true
    @State private var steps: Int = 524
    @State private var exerciseTime: Int = 16
    @State private var progress: Double = 0.51
    @State private var affectionLevel: Double = 0.3
    @State private var currentGif: String = "HospitalMotion.gif"
    @State private var goToHome: Bool = false
    
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
        }
        .animation(.easeInOut(duration: 0.5), value: goToHome) // 애니메이션 효과 적용
    }
    
    var walkview: some View {
        ZStack {
            Image("hospital_bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                StateView(affectionLevel: $affectionLevel, moneyAmount: .constant(250000), backgroundColor: .clear, isHospital: true)
                    .padding(.top, 50)
                    .padding(.trailing, -6)

                Spacer()
                
                AnimatedGifView(currentGif: $currentGif)
                    .frame(width: 253, height: 230)
                    .offset(x: 5, y: 22)
                
                Spacer()
                
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
                    .offset(x: 0, y: 72)
                }
                
                Spacer().frame(height: 240)
            }
        }
    }
    
//    var body: some View {
//        ZStack {
//            Color(Color.btnPink)
//                .edgesIgnoringSafeArea(.all)
//            // Background color
//            
//            VStack{
//                MainViewProf(affectionLevel:.constant(0.3),backgroundColor: Color.btnPink)
//                    .padding(EdgeInsets(top:-250, leading:0, bottom: 20, trailing: 0))
//                
//                Spacer()
//                
//                // Dog image
//                Image("dog")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 150, height: 150)
//                
//                // Home button above progress bar
//                HStack{
//                    Spacer()
//                    
//                    Button(action: {}) {
//                            Image("houseicon")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                        
//                    }
//                    .padding(EdgeInsets(top:0, leading:10, bottom: 20, trailing: 30))
//                    
//                }
//                
//                Image("dogwalkwithperson")
//                    .resizable()
//                    .frame(width: 35, height: 35)
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
//    }
    
    func goHome() {
        withAnimation {
            goToHome = true // fade 효과와 함께 HomeView로 전환
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
                    Image(systemName:"xmark")
                }
                .padding()
            }
            
            Text("걷기 시작하면 산책이 시작돼요.\n산책이 끝나면 집을 눌러주세요.\n함께 산책해 볼까요?")
                .font(.dw(.bold, size: 20))
                .lineSpacing(8)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top:-20, leading:10, bottom: 20, trailing: 10))
            
        }
        .background(Color.btnBeige)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.borderGray, lineWidth: 1))
        .padding()
    }
}

// Preview provider for SwiftUI previews
#Preview {
    WalkView()
}
