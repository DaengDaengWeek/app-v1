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
    @State private var backgroundOffset: CGFloat = 0
    @State private var showMainView = false
    
    
    @Environment(\.dismiss) var dismiss
    
    private let healthStore = HKHealthStore()
    
    var body: some View {  
        ZStack {
            // Moving background
                        GeometryReader { geometry in
                            Image("walkBackground") // 적절한 배경 이미지로 교체해주세요
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width * 2)
                                .offset(x: -backgroundOffset)
                                .ignoresSafeArea()
                        }
                        .onAppear {
                            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                                backgroundOffset = UIScreen.main.bounds.width
                            }
                        }
            
            VStack{
                MainViewProf(affectionLevel:.constant(0.3),backgroundColor: Color.clear)
                    .padding(EdgeInsets(top:-250, leading:0, bottom: 20, trailing: 0))
                
                Spacer()
                
                // Dog image
                AnimatedImage(name: "walkingdog.gif")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 200)
                    .offset(x:-99, y:-30)
                
                // Home button above progress bar
                HStack{
                    Spacer()
                    
                    Button(action: {
                        showMainView = true
                    }) {
                            Image("homeIcon")
                                .resizable()
                                .frame(width: 40, height: 40)
                        
                    }
                    .padding(EdgeInsets(top:0, leading:10, bottom: 20, trailing: 30))
                    .fullScreenCover(isPresented: $showMainView){
                        MainView()
                    }
                    
                }
                
                Image("dogwalkwithperson")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .offset(x: CGFloat(progress) * 325 - 150)
                    .padding(EdgeInsets(top:-10, leading:0, bottom: 5, trailing: 0))
                
                
                // Progress bar to show exercise progress
                HStack {
                    ProgressView(value: progress, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .frame(width: 325)
                        .scaleEffect(x: 1, y: 2.5, anchor: .center)
                }
                .padding(.horizontal)
                
                // Display step count and exercise time
                HStack {
                    Spacer()
                    Text("            \(steps)걸음")
                    Spacer()
                    Text("\(exerciseTime)분 / 30분")
                }
                .padding(.horizontal, 34)
                .font(.dw(.bold, size: 16))
                
                Spacer()
            }
            
            
            // Popup view
            if showPopup {
                PopupView(showPopup: $showPopup)
                    .padding(.horizontal, 20)
            }
        }
        .onAppear(perform: fetchHealthData) // Automatically start fetching health data
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
