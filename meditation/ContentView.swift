//
//  ContentView.swift
//  meditation
//
//  Created by Audrey Cheng on 2023-08-17.
//

import SwiftUI

struct ContentView: View {
    @State private var breathIn = false
    @State private var breathOut = false
    @State private var hold = true
    @State private var circuLarMotion = false
    @State private var displayHold = false
    @State private var displayBreathOut = false
    @State private var hideBreathOut = false
    @State private var hideBreathIn = false
    @State private var hideHold = false
    @State private var displaySecondHold = false
    @State private var hideSecondHold = false
    @State private var startButtonClicked = false
    
    let sun = Color(#colorLiteral(red: 0.8722043633, green: 0.6868960261, blue: 0.371203661, alpha: 1))
    let aqua = Color(#colorLiteral(red: 0.491617322, green: 0.6877334714, blue: 0.5810217857, alpha: 1))
    let iron = Color(#colorLiteral(red: 0.5234142542, green: 0.3825075626, blue: 0.3329478502, alpha: 1))
    let snow = Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
    let screenBackground = Image("breathe")
    let fillGradient = LinearGradient(gradient: Gradient(colors: [Color.orange, Color.mint]), startPoint: .bottomLeading, endPoint: .topTrailing)
    
    var body: some View {
        ZStack {
            Image("breathe")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            ZStack {
                
                fillGradient
                    .clipShape(
                        Circle())
                    .frame(width: 200, height: 200)
                
                Circle()
                    .stroke(lineWidth: 5)
                    .frame(width: 230, height: 230)
                    .foregroundColor(iron)
                
                Circle()
                    .trim(from: 0, to: 1/4)
                    .stroke(lineWidth: 5)
                    .frame(width: 230, height: 230)
                    .foregroundColor(aqua)
                    .rotationEffect(.degrees(-90))
                
                Circle()
                    .trim(from: 0, to: 1/4)
                    .stroke(lineWidth: 5)
                    .frame(width: 230, height: 230)
                    .foregroundColor(sun)
                    .rotationEffect(.degrees(90))
                
                Capsule()
                    .trim(from: 1/2, to: 1)
                    .frame(width: 20, height: 25)
                    .foregroundColor(snow)
                    .offset(y: 118)
                
                Capsule()
                    .trim(from: 1/2, to: 1)
                    .frame(width: 20, height: 25)
                    .foregroundColor(snow)
                    .rotationEffect(.degrees(180))
                    .offset(y: -118)
                
                Capsule()
                    .trim(from: 1/2, to: 1)
                    .frame(width: 20, height: 25)
                    .foregroundColor(snow)
                    .rotationEffect(.degrees(-90))
                    .offset(x: 118)
                
                Capsule()
                    .trim(from: 1/2, to: 1)
                    .frame(width: 20, height: 25)
                    .foregroundColor(snow)
                    .rotationEffect(.degrees(90))
                    .offset(x: -118)
                
                
                ZStack {
                    Circle()  // Path
                        .stroke()
                        .frame(width: 360, height: 360)
                        .opacity(0)
                    
                    Capsule()  // Rotating capsule
                        .trim(from: 1/2, to: 1)
                        .frame(width: 25, height: 25)
                        .foregroundColor(aqua)
                        .offset(y: 118)
                        .rotationEffect(.degrees(circuLarMotion ? 360 : 0))
                        .onAppear() {
                            withAnimation(Animation.linear(duration: 16)) {
                                circuLarMotion = true
                            }
                        }
                }
                
            }.frame(width: 360, height: 360)
                .scaleEffect(breathIn ? 1 : 0.8)
                .scaleEffect(hold ? 1 : 1)
                .scaleEffect(breathOut ? 0.8 : 1)
            
                .onAppear() {
                    withAnimation(Animation.linear(duration: 4)){
                        breathIn.toggle()
                    }
                    
                    withAnimation(Animation.linear(duration: 4).delay(4)){
                        hold.toggle()
                    }
                    
                    withAnimation(Animation.linear(duration: 4).delay(8)){
                        breathOut.toggle()
                    }
                    
                    withAnimation(Animation.linear(duration: 4).delay(12)){
                        hold.toggle()
                    }
                }
            ZStack {
                Text("Breath Out")
                    .foregroundColor(snow)
                    .scaleEffect(1)
                    .opacity(displayBreathOut ? 1 : 0)
                    .opacity(hideBreathOut ? 0 : 1)
                    .onAppear(){
                        withAnimation(Animation.easeInOut(duration: 0.4).delay(8)) {
                            displayBreathOut.toggle()
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 0.4).delay(12)) {
                            hideBreathOut.toggle()
                        }
                    }
                
                Text("Hold") // Second hold
                    .foregroundColor(snow)
                    .scaleEffect(1)
                    .opacity(displaySecondHold ? 1 : 0)
                    .opacity(hideSecondHold ? 0 : 1)
                    .onAppear(){
                        withAnimation(Animation.easeInOut(duration: 0.4).delay(12)) {
                            displaySecondHold.toggle()
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 0.4).delay(16)) {
                            hideSecondHold.toggle()
                        }
                    }
                
                Text("Hold")
                    .foregroundColor(snow)
                    .scaleEffect(1)
                    .opacity(displayHold ? 1 : 0)
                    .opacity(hideHold ? 0 : 1)
                
                    .onAppear(){
                        withAnimation(Animation.easeInOut(duration: 0.4).delay(4)) {
                            displayHold.toggle()
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 0.4).delay(8)) {
                            hideHold.toggle()
                        }
                    }
                
                Text("Breath In")
                    .foregroundColor(snow)
                    .opacity(hideBreathIn ? 0 : 1)
                    .animation(.easeInOut(duration: 0.4).delay(4), value: hideBreathIn)
                    .onAppear(){
                        hideBreathIn.toggle()
                    }
                
                HStack(spacing:50) {
                    Button("Start"){
                        startButtonClicked = true
                    }
                        .padding(.horizontal)
                        .foregroundColor(iron)
                        .buttonStyle(.bordered)
                        .border(Color(red: 0.523, green: 0.383, blue: 0.333, opacity: 1.0), width: 3)
                        .cornerRadius(3)
                        .tint(Color(red: 0.959, green: 0.924, blue: 0.925))
                    
                    Button("Stop"){
                        startButtonClicked = false
    
                    }
                        .foregroundColor(.red)
                        .buttonStyle(.bordered)
                        .padding(.horizontal)
                        .border(.red, width: 3)
                        .cornerRadius(3)
                        .tint(Color(red: 0.959, green: 0.924, blue: 0.925))
                }
            }
        }
    }
    
    struct CalmBreatheAnimation_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
    
}
