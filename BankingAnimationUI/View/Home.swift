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
    
    // MatchedGeometry Namespace
    @Namespace var animation
    
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
                    .rotation3DEffect(.init(degrees: animations[0] ? 0 : -200), axis: (x: 1, y: 1, z: 0), anchor: .center)
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
                        // Không sử dụng 2 câu lệnh trên vì để applying animation for background
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 40))
                        .frame(height: animations[2] ? nil : 0)
                        .vBottom()
                    
                    ZStack{
                        
                        // MARK: Intial Grid View
                        ForEach(colors){colorGrid in
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorGrid.color)
                                .frame(width: 150, height: animations[3] ? 60 : 150)
                                .matchedGeometryEffect(id: colorGrid.id, in: animation)
                
                            // MARK: Rotating Cards
                                .rotationEffect(.init(degrees: colorGrid.rotateCards ? 180 : 0))
                        }
                    }
                    // MARK: Applying Opacity with Scale Animation
                    // To Avoid this Creating with scale and hiding it
                    // So that it will look like a BG the whole stack is Applying Opacity Animation
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("BG"))
                            .frame(width: 150, height: animations[3] ? 60 : 150)
                            .opacity(animations[3] ? 0 : 1)

                    )
                    // Scale Effect
                    .scaleEffect(animations[3] ? 1 : 2.5)
                }
//                .hCenter()
//                .vCenter()
                
                // MARK: ScrollView with Color Grids
                ScrollView(.vertical, showsIndicators: false){
                    
                    let colums = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                    LazyVGrid(columns: colums, spacing: 15) {
                        
                        ForEach(colors){colorGrid in
                            
                            GridCardView(colorGrid: colorGrid)
 
                        }
                    }
                }
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
    
    // MARK: - Animated Credit Card
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
    
    // MARK: - MiddleBar
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
    
    // MARK: - Grid Card View
    @ViewBuilder
    func GridCardView(colorGrid: ColorGrid) -> some View {
        
        VStack{
            
            if colorGrid.addToGrid{
                
                // Displaying with matched Geometry Effect
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorGrid.color)
                    .frame(width: 150, height: 60)
                    .matchedGeometryEffect(id: colorGrid.id, in: animation)

                // When Animated Grid Card is Displayed Displaying the Color Text
                    .onAppear {
                        if let index = colors.firstIndex(where: { color in
                            return color.id == colorGrid.id
                        }){
                            withAnimation {
                                colors[index].showText = true
                            }
                        }
                    }
            }
            else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .frame(width: 150, height: 60)

            }
            
            Text(colorGrid.hexValue)
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.white)
                .hLeading()
                .padding([.horizontal, .top])
                .opacity(colorGrid.showText ? 1 : 0)
        }
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
        
        // Third Animation making the Bottom to Slide up eventually
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5).delay(0.5)) {
            animations[2] = true
        }
        
        // Third Animation Applying Opacity with scale animation for Stack Grid Colors
        withAnimation(.easeInOut(duration: 0.3)) {
            animations[3] = true
        }
        
        // Final Grid Forming Animation
        for index in colors.indices{
            
            // Animating after the opacity animation has Finished its job
            // Rotating One card another with a time delay of 0.1sec
            let delay: Double = (0.5 + (Double(index)*0.1))
            
            // Last card is rotating first since we're putting in ZStack
            // To avoid this recalulate index from back
            // Ta lấy chỉ số cuối cùng để card màu cuối cùng sẽ được quay đầu tiên
            let backIndex = ((colors.count - 1) - index)
            
            withAnimation(.easeInOut(duration: delay)) {
//                colors[index].rotateCards = true
                colors[backIndex].rotateCards = true
            }
            
            // After rotation adding it to grid view one after another
            // Since .delay() will not work on if...else
            // So using DispathQueue delay
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    colors[backIndex].addToGrid = true
                }
            }
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
