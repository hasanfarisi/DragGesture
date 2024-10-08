//
//  ContentView.swift
//  DragGesture
//
//  Created by mac on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showMenu:Bool = false
    @State private var offset = CGSize.zero
    var body: some View {
        
        let drag = DragGesture()
            .onChanged{
                gesture in
                self.offset = gesture.translation
            }
            .onEnded{
                value in
                self.offset = CGSize.zero
                self.showMenu = false
            }
        
        return ZStack{
            Color.orange
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("promo")
                    .resizable()
                    .frame(width: 300, height: 300)
                Button(action: {
                    withAnimation{
                        self.showMenu.toggle()
                    }
                }){
                    Text("Promo Merdeka").padding().background(Color.green).foregroundColor(Color.white).cornerRadius(20)
                }
            }
            if self.showMenu{
                Coupon()
                    .transition(.move(edge: .bottom))
                    .animation(.default)
                    .offset(y:self.offset.height)
                    .gesture(drag)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct Coupon:View {
    var body: some View {
        VStack{
            Text("Congratulation you've got an coupon")
                .font(.title)
                .bold()
                .foregroundColor(Color.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.red)
        .cornerRadius(20)
        .edgesIgnoringSafeArea(.bottom)
    }
}
