//
//  ContentView.swift
//  test-live-activity
//
//  Created by DucVinh on 14.08.2023.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct ContentView: View {
    @State var activity: Activity<MockData>? = nil
    @State var currentID: String = ""
    @State var currentState: ValueStatus = .assigning
    @State var timer: Timer? = nil
    @State var value: Double = 0
    var body: some View {
        NavigationStack {
            VStack{
                Picker(selection: $currentState, content: {
                    Text("Assigning")
                        .tag(ValueStatus.assigning)
                    Text("Accepted")
                        .tag(ValueStatus.accepted)
                    Text("Inprocess")
                        .tag(ValueStatus.inprocess)
                    Text("Completed")
                        .tag(ValueStatus.completed)
                }, label: {
                    
                }).labelsHidden()
                    .pickerStyle(.segmented)
                Button(action: {
                    print("tapped")
                    //showMyLiveActivity()
                    addLiveActivity()
                }, label: {
                    HStack(alignment: .center){
                        Text("Active")
                            .foregroundColor(.white)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                })
                .foregroundColor(.gray)
                .background(.gray)
                .cornerRadius(16)
                .frame(width: 200, height: 50, alignment: .center)
                .padding()
                Button(action: {
                    print("stop")
                    stopLiveActivity()
                    stopEtaTimer()
                    value = 100
                }, label: {
                    HStack(alignment: .center){
                        Text("Stop Activity")
                            .foregroundColor(.white)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                })
                    .background(Color.gray)
                    .cornerRadius(16)
                    .frame(width: 200, height: 50,  alignment: .center)
//                SimpleBarProgressView(progress: value)
//                    .onAppear {
//                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
//                            self.value += 0.1
//
//                            if value == 100 {
//                                timer?.invalidate()
//                            }
//                        }
//                    }
//                ProgressView("", value: value, total: 100)
//                    .progressViewStyle(StyleView())
//                    .padding()
//                    .onAppear {
//                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//                            self.value += 1
//
//                            if value == 98 {
//                                timer?.invalidate()
//                            }
//                        }
//                    }
                
                HStack (alignment: .center) {
                    ZStack(alignment: .center) {
                        ProgressView(value: value, total: 100)
                            .progressViewStyle(AnimationStyleView())
                            .animation(.linear(duration: 10))
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 6)
                        Image("ic_pick_up")
                            .frame(maxWidth: .infinity ,alignment: .bottomTrailing)
                    }
                }.frame(maxWidth: .infinity)
            }.navigationTitle("Activity")
                .padding(16)
                .frame(maxWidth: .infinity, maxHeight: 400)
                .onChange(of: currentState) { newValue in
                    if let activity = Activity.activities.first(where: {(activity: Activity<MockData>) in
                        activity.id == currentID
                    }){
                        var updateState = activity.content.state
//                            if updateState.status == ValueStatus.accepted
//                            {
////                                DispatchQueue.main.async {
////                                    Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
////                                        value += 1
////                                        Task {
////                                            await activity.update(using: updateState)
////                                        }
////                                    }
////                                    updateState.value = value
////                                }
//
////                                            Task {
////                                                await activity.update(using: updateState)
////                                            }
////                                    }
//                        }
                        DispatchQueue.main.async {
                            updateState.status = currentState
                            Task {
                                await activity.update(using: updateState)
                                
                            }
                        }
                    }
                }
        }
    }

    func addLiveActivity() {
        let mockDataAttribute = MockData()
        let initMockDataState = MockData.ContentState(value: self.value)
        let mockDataContent = ActivityContent(state: initMockDataState, staleDate: Calendar.current.date(byAdding: .minute, value: 30, to: Date())!)
        do{
            activity = try Activity.request(attributes: mockDataAttribute, content: mockDataContent)
            currentID = activity!.id
            print("Activity add sucess id: \(activity!.id)")
            Task {
                for await data in activity!.pushTokenUpdates {
                    let myToken = data.map {String(format: "%02x", $0)}.joined()
                    print("Token printed: \(myToken)")
                }
            }
        } catch (let error){
            print(error.localizedDescription)
        }
    }
    
    func updateLiceActivity() {
        let initMockDataState = MockData.ContentState(value: self.value)
        let mockDataContent = ActivityContent(state: initMockDataState, staleDate: nil)
        let status = initMockDataState.status
        if status == ValueStatus.assigning {
            
        }
        Task {
            await activity!.update(mockDataContent)
        }
    }
    
    func stopLiveActivity() {
        let initContentState = MockData.ContentState(value: self.value)
        let mockDataContent = ActivityContent(state: initContentState, staleDate: nil)
        Task{
            for activities in Activity<MockData>.activities {
                await activities.end(mockDataContent, dismissalPolicy: .immediate)
            }
            }
        }
    
     func startEtaTimer() {
        timer?.invalidate()
         let initContentState = MockData.ContentState(value: self.value)
         if initContentState.status == ValueStatus.accepted {
             timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
               print("Timer countdown finshes 10s")
             })
         }
    }
    
    func stopEtaTimer() {
        timer?.invalidate()
        print("Timer has stop!")
    }
}

struct StyleView: ProgressViewStyle {
    var color: Color = .purple
    var height: Double = 3.0
    var labelFontStyle: Font = .body
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionComleted = configuration.fractionCompleted ?? 0
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.gray)
                    .frame(maxWidth: .infinity, maxHeight: 3)
                    .frame(width: geometry.size.width)
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * fractionComleted, height: 3)
                Image("ic_driver")
                    .frame(width: (geometry.size.width + 280) * fractionComleted)
                }
            }
        }
    }

//struct SimpleBarProgressView: View {
//    let progress: CGFloat
//    
//    private let bgColor = Color.green.opacity(0.2)
//    private let fillColor = Color.green
//    
//    var body: some View {
//        VStack {
//            GeometryReader { bounds in
//                Capsule(style: .circular)
//                    .fill(bgColor)
//                    .overlay {
//                        HStack {
//                            Capsule(style: .circular)
//                                .fill(fillColor)
//                                .frame(width: bounds.size.width * progress)
//                            
//                            Spacer(minLength: 0)
//                        }
//                    }
//                    .clipShape(Capsule(style: .circular))
//            }
//            .frame(height: 15)
//        }
//    }
//}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension Binding<Double>: Equatable {
    public static func == (lhs: Binding<Double>, rhs: Binding<Double>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}
