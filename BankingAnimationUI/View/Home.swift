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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
