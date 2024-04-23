//
//  DrawingBoardContentView.swift
//  ZenUI
//
//  Created by David on 03.04.2024.
//

import Foundation
import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .red
    var lineWidth: Double = 1.0
}

struct Constants {
    struct Icons {
        static let recordCircleFill = "record.circle.fill"
        static let circleFill = "circle.fill"
    }
}

struct ColorPickerView: View {
    let colors = [Color.red, Color.orange, Color.green, Color.blue, Color.purple]
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                Image(systemName: selectedColor == color ? Constants.Icons.recordCircleFill : Constants.Icons.circleFill)
                    .foregroundColor(color)
                    .font(.system(size: 24))
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

public struct DrawingBoardContentView: View {
    public init() { }
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 1.0
    
    public var body: some View {
        VStack {
            Canvas { context, size in
                // Draw all completed lines
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
                // Draw the current line being drawn
                var currentPath = Path()
                currentPath.addLines(currentLine.points)
                context.stroke(currentPath, with: .color(currentLine.color), lineWidth: currentLine.lineWidth)
            }
            .frame(width: 300, height: 450)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    let newPoint = value.location
                    currentLine.points.append(newPoint) // Update the current line with new points
                })
                .onEnded({ value in
                    self.lines.append(currentLine) // Add completed line to lines array
                    self.currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness) // Reset currentLine
                })
            )
            
            HStack {
                Slider(value: $thickness, in: 1...20) {
                    Text("Thickness")
                }.frame(width: 150)
                
                Divider()
                
                ColorPickerView(selectedColor: $currentLine.color)
            }
        }.padding()
    }
}

struct DrawingBoardContentView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingBoardContentView()
    }
}
