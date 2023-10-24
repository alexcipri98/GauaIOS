//
//  Extensions.swift
//  Gaua
//
//  Created by Alex Ciprián López on 22/7/23.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}


extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}


extension Color {
    init(hex: String, alpha: Double = 1.0) {
        let hex = hex.filter { "0123456789abcdefABCDEF".contains($0) }
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        
        scanner.scanHexInt64(&hexNumber)
        
        let red = Double((hexNumber & 0xff0000) >> 16) / 255
        let green = Double((hexNumber & 0x00ff00) >> 8) / 255
        let blue = Double(hexNumber & 0x0000ff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var result: [[Element]] = []
        var index = 0
        
        while index < count {
            let chunkSize = Swift.min(count - index, size)
            let chunk = Array(self[index..<index + chunkSize])
            result.append(chunk)
            index += chunkSize
        }
        
        return result
    }
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var image: UIImage {
        return UIImage(named: self) ?? UIImage()
    }
    
}
