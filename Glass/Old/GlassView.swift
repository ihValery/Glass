//
//  GlassView.swift
//  Glass
//
//  Created by Валерий Игнатьев on 24.05.22.
//

import SwiftUI

//MARK: - GlassView

struct GlassView: View {
    
    //MARK: Properties
    
    @State private var gestureValue: CGSize = .zero
    
    var body: some View {
        ZStack {
            card
                .background(glass)
                .blendMode(.overlay)
                .cornerRadius(25)
                .overlay(overlayCard)
                .offset(x: gestureValue.width, y: gestureValue.height)
                .shadow(color: .white.opacity(0.4), radius: 3, x: 0, y: -3)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 0.1
                                                 )) {
                                gestureValue = value.translation
                            }
                        }
                )
        }
        
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(imageFlora)
        .clipped()
        .ignoresSafeArea()
    }
    
    private var imageTEST: some View {
        Image("backFlora")
            .offset(x: -gestureValue.width, y: -gestureValue.height)
    }
    
    private var card: some View {
        LinearGradient(colors: [.white.opacity(0.7), .white.opacity(0.1)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .opacity(0.3)
        .frame(width: 300, height: 200)
    }
    
    private var glass: some View {
        Image("backFlora")
            .offset(x: -gestureValue.width, y: -gestureValue.height)
            .overlay(glareBlack)
            .frame(width: 300, height: 200)
            .blur(radius: 1)
            .scaleEffect(1.01)
            .overlay(glare)
            .clipped()
    }
    
    private var overlayCard: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(LinearGradient(colors: [.white.opacity(0.5), .clear, .white.opacity(0.5)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
    private var imageFlora: some View {
        Image("backFlora")
    }
    
    private var glare: some View {
        Capsule()
            .fill(.white)
            .frame(width: 5, height: 140)
            .blur(radius: 3)
            .offset(x: -120)
//            .opacity(0.6)
    }
    
    private var glareBlack: some View {
        Capsule()
            .fill(.black)
            .frame(width: 5, height: 140)
            .blur(radius: 4)
            .offset(x: -120)
            .offset(x: -5, y: 5)
            .opacity(0.08)
    }
}

//MARK: - PreviewProvider

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GlassView()
    }
}
