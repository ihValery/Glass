//
//  DragGestureView.swift
//  Glass
//
//  Created by Валерий Игнатьев on 26.05.22.
//

import SwiftUI

//MARK: - DragGestureView

struct DragGestureView: View {
    
    //MARK: Internal Constant
    
    internal struct Constant {
        static let rectangle: CGSize = .init(width: 200, height: 123)
        static let centerX = UIScreen.main.bounds.width / 2
        static let centerY = UIScreen.main.bounds.height / 2
    }
    
    //MARK: Properties
    
    @State private var location: CGPoint = .init(x: Constant.centerX, y: Constant.centerY)
    
    @GestureState private var fingerLocation: CGPoint?
    
    @GestureState private var startLocation: CGPoint?
    
    var body: some View {
        GeometryReader { grProxy in
            purpleRectangle
                .gesture(simpleDrag(grProxy).simultaneously(with: fingerDrag))
        }
        .ignoresSafeArea()
    }
    
    private var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { value, fingerLocation, _ in
                fingerLocation = value.location
            }
    }
    
    private var purpleRectangle: some View {
        RoundedRectangle(cornerRadius: 13, style: .continuous)
            .foregroundColor(.purple)
            .frame(width: Constant.rectangle.width,
                   height: Constant.rectangle.height)
            .position(location)
            .overlay(fingerPrint)
    }
    
    @ViewBuilder private var fingerPrint: some View {
        if let fingerLocation = fingerLocation {
            Image("fingerPrintCapsule")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .scaledToFit()
                .blendMode(.overlay)
                .frame(width: 50, height: 50)
                .position(fingerLocation)
        }
    }
    
    //MARK: Private Methods

    private func simpleDrag(_ grproxy: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 1)
            .updating($startLocation) { _, startLocation, _ in
                startLocation = startLocation ?? location
            }
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                
                location = newLocation
            }
            .onEnded { value in
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    if location.x < Constant.rectangle.width / 2 {
                        location.x = Constant.rectangle.width / 2 + 3
                    }
                    
                    if location.y < Constant.rectangle.height / 2 + 36 {
                        location.y = Constant.rectangle.height / 2 + 36
                    }
                    
                    if location.x > grproxy.size.width - Constant.rectangle.width / 2 {
                        location.x = grproxy.size.width - Constant.rectangle.width / 2 - 3
                    }
                    
                    if location.y > grproxy.size.height - Constant.rectangle.height / 2 {
                        location.y = grproxy.size.height - Constant.rectangle.height / 2 - 3
                    }
                }
            }
    }
}

//MARK: - PreviewProvider

struct DragGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}
