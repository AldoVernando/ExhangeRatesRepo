//
//  CustomExchangeShape.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import SwiftUI

/**
A custom `Shape` that defines a custom drawing path for an exchange-related view.
*/
struct CustomeExchangeShape: Shape {
    
    /**
     Creates a custom drawing path within the specified rectangle.
     
     - Parameter rect: The rectangle in which the drawing path is created.
     - Returns: A `Path` representing the custom drawing path.
     */
    func path(in rect: CGRect) -> Path {
        var pencil: Path = .init()
        
        // Move to the starting point (top-left corner of the rectangle).
        pencil.move(to: .init(x: rect.minX, y: rect.minY))
        
        // Create custom path by adding lines.
        pencil.addLine(to: .init(x: rect.minX, y: rect.minY))
        pencil.addLine(to: .init(x: rect.midX, y: rect.minY))
        pencil.addLine(to: .init(x: rect.midX + 20, y: rect.midY))
        pencil.addLine(to: .init(x: rect.midX, y: rect.maxY))
        pencil.addLine(to: .init(x: rect.midX, y: rect.maxY))
        pencil.addLine(to: .init(x: rect.minX, y: rect.maxY))
        
        // Close the path to form a closed shape.
        pencil.closeSubpath()
        
        return pencil
    }
}
