//
//  OnboardingView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/9/25.
//

import SwiftUI
import AppTrackingTransparency

struct OnboardingView: View {

    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false

    @Environment(\.theme) var theme

    var body: some View {
        ZStack {
            GeometryReader { _ in
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
                    Spacer()

                    Button(LocalizedStringKey("get_started")) {
                        // ATT on first launch for upcoming ads (NSUserTrackingUsageDescription in Info.plist).
                        // Finish onboarding after the system prompt so the alert can present.
                        requestTrackingPermission {
                            hasSeenOnboarding = true
                        }
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
            .readableContentWidth()
        }
    }

    /// Requests ATT, then runs `completion` on the main queue (authorized, denied, or already decided).
    private func requestTrackingPermission(completion: @escaping () -> Void) {
        // Defer one run-loop turn so the alert presents while this view is still active.
        DispatchQueue.main.async {
            ATTrackingManager.requestTrackingAuthorization { _ in
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
