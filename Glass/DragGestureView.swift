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
        }
    }
    
    private var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                
                location = newLocation
            }
            .updating($startLocation) { value, fingerLocation, transaction in
                fingerLocation = startLocation ?? location
            }
    }
    
    private var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { value, fingerLocation, transaction in
                fingerLocation = value.location
            }
    }
    
    private var purpleRectangle: some View {
        RoundedRectangle(cornerRadius: 13, style: .continuous)
            .foregroundColor(.purple)
            .frame(width: Constant.rectangle.width,
                   height: Constant.rectangle.height)
            .position(location)
            .gesture(simpleDrag.simultaneously(with: fingerDrag))
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
}

//MARK: - PreviewProvider

struct DragGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}
