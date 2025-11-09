//
//  OnboardingView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/9/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image("img_on_boarding")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea()
            }
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                Spacer()
                    .frame(height: 72)
                
                Text("¿Estás listo para hoy?")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Text("Encontremos juntos tu próximo concierto.")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                HStack {
                    Spacer() // pushes the button to the right
                    
                    Button("Empecemos") {
                        hasSeenOnboarding = true
                    }
                    .padding()
                    .fontWeight(.bold)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .frame(alignment: .trailing)
                    
                    Spacer() // pushes the button to the left
                }
            }
            .padding()
        }
    }
}
