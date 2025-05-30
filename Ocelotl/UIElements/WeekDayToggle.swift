//
//  WeekDayToggleStyle.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 25/05/2025.
//

import SwiftUI

struct WeekDayToggle: View {
    enum Segment {
        case today
        case week
    }
    
    @State private var selectedSegment: Segment = .today
    
    var body: some View {
        HStack(spacing: 0) {
            segmentButton(
                title: "Today",
                isSelected: selectedSegment == .today,
                roundedCorners: selectedSegment == .today ?
                [.topLeft, .bottomLeft, .topRight, .bottomRight] :
                    [.topLeft, .bottomLeft],
                missingBorder: .right
            ) {
                selectedSegment = .today
            }
            
            segmentButton(
                title: "Week",
                isSelected: selectedSegment == .week,
                roundedCorners: selectedSegment == .week ?
                [.topLeft, .bottomLeft, .topRight, .bottomRight] :
                    [.topRight, .bottomRight],
                missingBorder: .left
            ) {
                selectedSegment = .week
            }
        }
    }
    
    private func segmentButton(
        title: String,
        isSelected: Bool,
        roundedCorners: UIRectCorner,
        missingBorder: BorderSide,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(Styleguide.body())
                .frame(width: 60, height: 30)
                .foregroundColor(
                    isSelected ? Styleguide.getAlmostWhite() : Styleguide.getBlue()
                )
                .background(
                    ZStack {
                        RoundedCorner(radius: 4, corners: roundedCorners)
                            .fill(
                                isSelected ? Styleguide.getOrange() : Styleguide.getAlmostWhite()
                            )
                        
                        if !isSelected {
                            CustomBorderShape(corners: roundedCorners, excluding: missingBorder, radius: 4)
                                .stroke(Styleguide.getOrange(), lineWidth: 1)
                        }
                    }
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - BorderSide

enum BorderSide {
    case top, bottom, left, right
}

// MARK: - RoundedCorner Shape

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - CustomBorderShape

struct CustomBorderShape: Shape {
    var corners: UIRectCorner
    var excluding: BorderSide
    var radius: CGFloat = 10
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let tl = CGPoint(x: rect.minX, y: rect.minY)
        let tr = CGPoint(x: rect.maxX, y: rect.minY)
        let br = CGPoint(x: rect.maxX, y: rect.maxY)
        let bl = CGPoint(x: rect.minX, y: rect.maxY)
        
        let hasTopLeft = corners.contains(.topLeft)
        let hasTopRight = corners.contains(.topRight)
        let hasBottomRight = corners.contains(.bottomRight)
        let hasBottomLeft = corners.contains(.bottomLeft)
        
        func arc(to point: CGPoint, clockwise: Bool) {
            path.addArc(tangent1End: path.currentPoint ?? point, tangent2End: point, radius: radius)
        }
        
        path.move(to: CGPoint(x: tl.x + (hasTopLeft ? radius : 0), y: tl.y))
        
        // TOP
        if excluding != .top {
            path.addLine(to: CGPoint(x: tr.x - (hasTopRight ? radius : 0), y: tr.y))
            if hasTopRight {
                path.addArc(center: CGPoint(x: tr.x - radius, y: tr.y + radius),
                            radius: radius,
                            startAngle: Angle(degrees: 270),
                            endAngle: Angle(degrees: 0),
                            clockwise: false)
            }
        } else {
            path.move(to: CGPoint(x: tr.x, y: tr.y))
        }
        
        // RIGHT
        if excluding != .right {
            path.addLine(to: CGPoint(x: br.x, y: br.y - (hasBottomRight ? radius : 0)))
            if hasBottomRight {
                path.addArc(center: CGPoint(x: br.x - radius, y: br.y - radius),
                            radius: radius,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 90),
                            clockwise: false)
            }
        } else {
            path.move(to: CGPoint(x: br.x, y: br.y))
        }
        
        // BOTTOM
        if excluding != .bottom {
            path.addLine(to: CGPoint(x: bl.x + (hasBottomLeft ? radius : 0), y: bl.y))
            if hasBottomLeft {
                path.addArc(center: CGPoint(x: bl.x + radius, y: bl.y - radius),
                            radius: radius,
                            startAngle: Angle(degrees: 90),
                            endAngle: Angle(degrees: 180),
                            clockwise: false)
            }
        } else {
            path.move(to: CGPoint(x: bl.x, y: bl.y))
        }
        
        // LEFT
        if excluding != .left {
            path.addLine(to: CGPoint(x: tl.x, y: tl.y + (hasTopLeft ? radius : 0)))
            if hasTopLeft {
                path.addArc(center: CGPoint(x: tl.x + radius, y: tl.y + radius),
                            radius: radius,
                            startAngle: Angle(degrees: 180),
                            endAngle: Angle(degrees: 270),
                            clockwise: false)
            }
        }
        
        return path
    }
}

// MARK: - Preview

struct WeekDayToggle_Previews: PreviewProvider {
    static var previews: some View {
        WeekDayToggle()
            .padding()
    }
}
