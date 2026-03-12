//
//  MapPinCircleIcon.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-12.
//

import SwiftUI

// Triangle tail for the pin
struct PinTrianglee: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

struct MapPinCircleIcon: View {
    var circleColor: Color = Color(hex: "#2196F3")
    var size: CGFloat = 12  // Matches your clock icon size
    var hasDot: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Outer circle
                Circle()
                    .fill(circleColor)
                    .frame(width: size, height: size)
                
                // Inner white circle
                Circle()
                    .fill(Color.white)
                    .frame(width: size * 0.45, height: size * 0.45)
                
                // Small colored dot in the center
                if hasDot {
                    Circle()
                        .fill(circleColor)
                        .frame(width: size * 0.2, height: size * 0.2)
                }
            }
            
            // Triangle tail
            PinTriangle()
                .fill(circleColor)
                .frame(width: size * 0.35, height: size * 0.28)
        }
        .frame(width: size, height: size + size * 0.28)
    }
}

#Preview {
    HStack(spacing: 5) {
        MapPinCircleIcon(size: 12)
        Text("9:00 AM - 5:00 PM")
            .font(.system(size: 12))
            .foregroundColor(Color(hex: "#555555"))
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}
