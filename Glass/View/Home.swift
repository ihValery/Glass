//
//  Home.swift
//  Glass
//
//  Created by Валерий Игнатьев on 25.04.23.
//

import SwiftUI

struct Home: View {
    
    //MARK: Properties
    
    @State private var scale: CGFloat = 0
    @State private var rotation: CGFloat = 0
    @State private var size: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader {
                let size = $0.size
                
                Image("pexelsImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
                    .magnificationEffect(scale, rotation, self.size)
            }
            .padding(50)
            .contentShape(Rectangle())
            
            //MARK: - Customization options
            VStack(alignment: .leading, spacing: 0) {
                Text("Customization")
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.top)
                
                HStack(spacing: 14) {
                    Text("Scale")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 35, alignment: .leading)
                    
                    Slider(value: $scale)
                    
                    Text("Rotation")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Slider(value: $rotation)
                }
                .padding(.top)
                
                HStack(spacing: 14) {
                    Text("Size")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 35, alignment: .leading)
                    
                    Slider(value: $size, in: -20...100)
                }
            }
            .padding(.horizontal)
            .tint(.black)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.white)
                    .ignoresSafeArea()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.black
                .opacity(0.08)
                .ignoresSafeArea()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//MARK: - Custom view modifier

extension View {
    @ViewBuilder func magnificationEffect(_ scale: CGFloat,
                                          _ rotation: CGFloat,
                                          _ size: CGFloat = 0) -> some View {
        MagnigicationEffectHelper(scale: scale, rotation: rotation, size: size) {
            self
        }
    }
}

//MARK: - Magnification effect helper

fileprivate struct MagnigicationEffectHelper<Content: View>: View {
    
    //MARK: Properties

    var scale: CGFloat
    var rotation: CGFloat
    var size: CGFloat
    
    var content: Content
    
    init(scale: CGFloat,
         rotation: CGFloat,
         size: CGFloat,
         @ViewBuilder content: @escaping() -> Content) {
     
        self.scale = scale
        self.rotation = rotation
        self.size = size
        self.content = content()
    }
    
    //MARK: Gesture Properties

    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    
    var body: some View {
        content
            .overlay {
                GeometryReader {
                    let newCircleSize = 175.0 + size
                    let size = $0.size
                    
                    content
//                        .frame(width: size.width, height: size.height)
                        .frame(width: newCircleSize, height: newCircleSize)
                        .scaleEffect(1 + scale)
                        .clipShape(Circle())
                        .frame(width: size.width, height: size.height)
                }
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offset = value.translation
                    })
                    .onEnded({ _ in
                        lastStoredOffset = offset
                    })
            )
    }
}

