//
//  Home.swift
//  BankingAnimationUI
//
//  Created by Quang Bao on 21/01/2022.
//

import SwiftUI

struct Home: View {
    
    // MARK: Sample Colors
    @State var colors: [ColorGrid] = [
        
        ColorGrid(hexValue: "#53AFFF", color: Color("Blue")),
        ColorGrid(hexValue: "#9DE26F", color: Color("Green")),
        ColorGrid(hexValue: "#FF9352", color: Color("Orange")),
        ColorGrid(hexValue: "#FF74BD", color: Color("Pink")),
        ColorGrid(hexValue: "#DF70FF", color: Color("Violet")),
        ColorGrid(hexValue: "#FFE272", color: Color("Yellow"))

    ]
    
    // MARK: Animation Properties
    // Instead of making each boolean for separate animation making it as an array to void multiple lines of code.
    @State var animations: [Bool] = Array(repeating: false, count: 10)
    
    var body: some View {
        VStack{
            
            HStack{
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .hLeading()
                
                Button {
                    
                } label: {
                    Image("Avatar")
                        .resizable()
                        //.aspectRatio(contentMode: .fill)
                        //.scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .stroke(.white, lineWidth: 1)
                        )
                }
                .hTrailing()
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 5)
            
            // MARK: Using Geometry Reader for Setting Offset
            GeometryReader{proxy in
                
                let maxY = proxy.frame(in: .global).maxY
                
                CreditCard()
                // MARK: 3D Rotation
                    .rotation3DEffect(.init(degrees: animations[0] ? 0 : -200), axis: (x: 1, y: 0, z: 0), anchor: .center)
                    .offset(y: animations[0] ? 0 : -maxY)

            }
            .frame(height: 250)
            
            MiddleBar()
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                ZStack{
                    
                    Color(.black)
                        //.cornerRadius(35)
                        //.edgesIgnoringSafeArea(.bottom)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 40))
                        .frame(height: animations[2] ? nil : 0)
                        .vBottom()
                }
//                .hCenter()
//                .vCenter()
            }
            .padding(.top)
            
        }
        .vTop()
        .hCenter()
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("BG"))
        .onAppear {
            animateScreen()
        }
    }
    
    // MARK: Animated Credit Card
    @ViewBuilder
    func CreditCard() -> some View {
        
        ZStack{

            RoundedRectangle(cornerRadius: 15)
                .fill(Color("Pink"))
            
            VStack{
                
                HStack{
                    ForEach(1...4,id: \.self){_ in
                        Circle()
                            .fill(.white)
                            .frame(width: 5, height: 5)
                    }
                    
                    Text("8684")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .hLeading()
                
                HStack(spacing: -12){
                    
                    Text("Hoang Quang Bao")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .hLeading()
                    
                    Circle()
                        .stroke(.white, lineWidth: 1)
                        .frame(width: 30, height: 30)
                    
                    Circle()
                        .stroke(.white, lineWidth: 1)
                        .frame(width: 30, height: 30)
                }
                .vBottom()
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
            .vTop()
            //.hLeading()
            
            Circle()
                .stroke(.white.opacity(0.5),lineWidth: 15)
                .offset(x: 150, y: -150)
        }
        .clipped()
//        .frame(height: 250)
        .padding()
        
//        ZStack{
//
//            RoundedRectangle(cornerRadius: 15)
//                .fill(Color("Pink"))
//                .frame(height: 250)
//
//            VStack{
//
//                HStack{
//
//                    Text("7864")
//                        .font(.caption2)
//                        .foregroundColor(.white)
//
//                    Circle()
//                        .stroke(.white, lineWidth: 10)
//                        .frame(width: 200, height: 200)
//                        .offset(x: 100, y: -100)
//                }
//
//                HStack{
//                    Text("Jenna Ezarik")
//                        .foregroundColor(.white)
//                        .font(.body)
//
//                    Spacer()
//
//                    Circle()
//                        .stroke(.white, lineWidth: 2)
//                        .frame(width: 30, height: 30)
//
//                    Circle()
//                        .stroke(.white, lineWidth: 2)
//                        .frame(width: 30, height: 30)
//                        .offset(x: -20)
//
//                }
//            }
//        }
//        .clipped()
//        .padding()
//        .hCenter()
    }
    
    // MARK: MiddleBar
    func MiddleBar() -> some View {
        
        HStack{
            
            Text("Choose a color")
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.semibold)
                .hLeading()
                .offset(x: animations[1] ? 0 : -200)
            
            Button {
                
            } label: {
                
                Text("View all")
                    .font(.title3)
                    .foregroundColor(Color("Pink"))
                    .underline()
            }
            .offset(x: animations[1] ? 0 : 200)

        }
        .padding(.horizontal)
    }
    
    // MARK: AnimatingScreen
    func animateScreen() {
        
        // First Animation of Credit Card
        withAnimation(.interactiveSpring(response: 2, dampingFraction: 0.5, blendDuration: 0.5).delay(0.5)) {
            animations[0] = true
        }
        
        // Second Animating the Hstack with View All Button
        withAnimation(.easeInOut(duration: 0.7)) {
            animations[1] = true
        }
        
//        withAnimation(.easeIn(duration: 0.7)) {
//            animations[1] = true
//        }
        
        // Third Animation making the Bottom to Slide up eventually
        withAnimation(.interactiveSpring(response: 2, dampingFraction: 0.5, blendDuration: 0.5).delay(0.5)) {
            animations[2] = true
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// MARK: Extensions for Making UI Design Faster
extension View{
    
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    func vCenter() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }
    
    func vTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }
    
    func vBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
}
