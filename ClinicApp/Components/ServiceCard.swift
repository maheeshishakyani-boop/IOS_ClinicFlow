//
//  ServiceCard.swift
//  ClinicApp
//
//  Created by BSCComp-046 on 2026-03-13.
//

//
//  ServiceCard.swift
//  ClinicApp
//
//  Created by YourName on 2026-03-13.
//

import SwiftUI

struct ServiceCard: View {
    let icon: String
    let title: String
    let color: Color

    var body: some View {
        VStack(spacing: 14) {
            Circle()
                .fill(color.opacity(0.12))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(color)
                )
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(.primary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 12, y: 4)
        )
    }
}

#Preview {
    ServiceCard(icon: "person.3.sequence.fill", title: "Track My Queue", color: .blue)
        .padding()
}
