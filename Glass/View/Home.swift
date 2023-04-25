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
