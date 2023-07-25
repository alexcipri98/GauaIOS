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
