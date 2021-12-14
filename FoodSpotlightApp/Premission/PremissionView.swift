//
//  PermissionView.swift
//  FoodSpotlightApp
//
//  Created by iosdev on 26.11.2021.
//

import SwiftUI

struct PermissionView: View {
    
    @State var isAnimating = false
    let action: () -> Void
    
    // animation  
    var animation : Animation {
        .interpolatingSpring(stiffness: 0.5, damping: 0.5)
            .repeatForever()
            .delay(isAnimating ? .random(in: 0...1):0)
            .speed(isAnimating ? .random (in:0.1...1):0)
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack{
                //Images
                ZStack {
                    ForEach(1 ..< 14 ) {i in
                        Image("food\(i % 7)")
                            .resizable()
                            .frame(width: 50, height:50)
                            .position(x: .random(in:0...proxy.size.width), y: .random(in: 0...proxy.size.height / 2)
                            )
                            .animation(animation)
                    }
                }.frame(height: proxy.size.height / 3)

                // Text & Button
                Text(L10n.splfood)
                    .font(.custom(.poppinsSemibold, size: 50))
                    .padding(.bottom, .large)
                    

                Text(L10n.findNewCoolSpotsToEat)
                    .font(.custom(.poppinsMedium, size: 22))

                Spacer()
                    .frame(width: nil)

                // Button
                Button(action: action) {
                    Text(L10n.getStarted)
                        .font(.custom(.poppinsMedium, size: 16))
                }
                .padding()
                .frame(maxWidth: proxy.size.width - 50)
                .background(Color.blue)
                .cornerRadius(40)
                .modifier(ShadowModifier())
                .foregroundColor(.white)
            }
        }.onAppear {
            isAnimating.toggle()
        }
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView() {}
    }
}
