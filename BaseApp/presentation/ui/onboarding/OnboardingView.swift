//
//  OnboardingView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/9/25.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

struct OnboardingView: View {
    
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    
    @Environment(\.theme) var theme
    
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
                
                Text(LocalizedStringKey("are_you_ready_for_tonight"))
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Text(LocalizedStringKey("let_find_out_together"))
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                HStack {
                    Spacer() // pushes the button to the right
                    
                    Button(LocalizedStringKey("get_started")) {
                        requestTrackingPermission()
                        hasSeenOnboarding = true
                    }
                    .padding()
                    .fontWeight(.bold)
                    .background(theme.accent)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .frame(alignment: .trailing)
                    
                    Spacer() // pushes the button to the left
                }
            }
            .padding()
        }
    }
    
    func requestTrackingPermission() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("Tracking authorized")
            case .denied:
                print("Tracking denied")
            case .restricted:
                print("Tracking restricted")
            case .notDetermined:
                print("Tracking not determined")
            @unknown default:
                break
            }
        }
    }
}
