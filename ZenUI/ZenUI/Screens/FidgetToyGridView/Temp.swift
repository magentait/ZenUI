//
//  Temp.swift
//  ZenUI
//
//  Created by David on 21.04.2024.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.ignoresSafeArea()
                NewtonsCradle(colors: [.red, .green, .blue, .orange, .purple])
                    .frame(width: min(geometry.size.width, geometry.size.height * 0.8),
                           height: min(geometry.size.width, geometry.size.height) * 0.1)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}


struct NewtonsCradle: UIViewRepresentable {
    
    let colors: [UIColor]
    let ballSize: CGSize = CGSize(width: 50, height: 50)
    let ballPadding: CGFloat = 10.0
    
    func makeUIView(context: Context) -> UIView {
        let totalWidth = CGFloat(colors.count) * ballSize.width + CGFloat(colors.count - 1) * ballPadding
        let height = ballSize.height * 2 // assuming some space for movement
        let cradle = NewtonsCradleView(colors: colors, ballSize: ballSize, ballPadding: ballPadding)
        cradle.frame = CGRect(x: 0, y: 0, width: totalWidth, height: height)
        return cradle
    }

    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

class NewtonsCradleView: UIView {
    
    let colors: [UIColor]
    var balls: [UIView] = []
    var animator: UIDynamicAnimator?
    var ballsToAttachmentBehaviors: [UIView:UIAttachmentBehavior] = [:]
    var snapBehavior: UISnapBehavior?
    
    let collisionBehavior: UICollisionBehavior
    let gravityBehavior: UIGravityBehavior
    let itemBehavior: UIDynamicItemBehavior
    
    init(colors: [UIColor], ballSize: CGSize, ballPadding: CGFloat) {
        self.colors = colors
        collisionBehavior = UICollisionBehavior(items: [])
        gravityBehavior = UIGravityBehavior(items: [])
        itemBehavior = UIDynamicItemBehavior(items: [])
        
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        
        animator = UIDynamicAnimator(referenceView: self)
        animator?.addBehavior(collisionBehavior)
        animator?.addBehavior(gravityBehavior)
        animator?.addBehavior(itemBehavior)
        
        createBallViews(ballSize: ballSize, ballPadding: ballPadding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        for ball in balls {
            ball.removeObserver(self, forKeyPath: "center")
        }
    }
    
    var useSquaresInsteadOfBalls: Bool = false {
        didSet {
            for ball in balls {
                if useSquaresInsteadOfBalls {
                    ball.layer.cornerRadius = 0
                }
                else {
                    ball.layer.cornerRadius = ball.bounds.width / 2.0
                }
            }
        }
    }
    
    // MARK: Ball Views
    
    func createBallViews(ballSize: CGSize, ballPadding: CGFloat) {
        for color in colors {
            let ball = UIView(frame: CGRect.zero)
            ball.backgroundColor = color
            ball.layer.cornerRadius = ballSize.width / 2.0
            ball.layer.shadowOpacity = 0.7
            ball.layer.shadowRadius = 5
            ball.layer.shadowOffset = CGSize(width: 3, height: 3)
            addSubview(ball)
            balls.append(ball)
        }
        layoutBalls(ballSize: ballSize, ballPadding: ballPadding)
    }
    
    // MARK: Properties
    
    var attachmentBehaviors: [UIAttachmentBehavior] {
        var attachmentBehaviors: [UIAttachmentBehavior] = []
        for ball in balls {
            guard let attachmentBehavior = ballsToAttachmentBehaviors[ball] else { fatalError("Can't find attachment behavior for \(ball)") }
            attachmentBehaviors.append(attachmentBehavior)
        }
        return attachmentBehaviors
    }

    
    
    // MARK: Ball Layout
    
    func layoutBalls(ballSize: CGSize, ballPadding: CGFloat) {
        let totalWidth = CGFloat(balls.count) * ballSize.width + CGFloat(balls.count - 1) * ballPadding
        let startX = (bounds.width - totalWidth) / 2 + 190

        print("Total Width: \(totalWidth), StartX: \(startX), Bounds Width: \(bounds.width)")

        for (index, ball) in balls.enumerated() {
            let ballXOrigin = startX + CGFloat(index) * (ballSize.width + ballPadding)
            ball.frame = CGRect(x: ballXOrigin, y: bounds.midY - ballSize.height / 2, width: ballSize.width, height: ballSize.height)
            print("Ball \(index) Frame: \(ball.frame)")
            ball.layer.cornerRadius = ball.bounds.width / 2.0

            let attachmentPoint = CGPoint(x: ball.frame.midX, y: bounds.midY - 50)
            let attachmentBehavior = UIAttachmentBehavior(item: ball, attachedToAnchor: attachmentPoint)
            ballsToAttachmentBehaviors[ball] = attachmentBehavior
            animator?.addBehavior(attachmentBehavior)

            collisionBehavior.addItem(ball)
            gravityBehavior.addItem(ball)
            itemBehavior.addItem(ball)
        }
    }

    

    
    // MARK: Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: superview)
            for ball in balls {
                if (ball.frame.contains(touchLocation)) {
                    snapBehavior = UISnapBehavior(item: ball, snapTo: touchLocation)
                    animator?.addBehavior(snapBehavior!)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: superview)
            if let snapBehavior = snapBehavior {
                snapBehavior.snapPoint = touchLocation
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let snapBehavior = snapBehavior {
            animator?.removeBehavior(snapBehavior)
        }
        snapBehavior = nil
    }
    
    // MARK: KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "center") {
            setNeedsDisplay()
        }
    }
    
    // MARK: Drawing
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Calculate the highest point any ball reaches to position the bar accordingly
        let highestBallPoint = balls.reduce(CGFloat.infinity) { (current, ball) -> CGFloat in
            min(current, ball.frame.minY)
        }
        
        // Drawing the top bar
        let barHeight: CGFloat = 20
        let barYPosition = highestBallPoint - 30  // Place bar 30 points above the highest ball
        context.setFillColor(UIColor.darkGray.cgColor)
        context.addRect(CGRect(x: bounds.minX, y: barYPosition, width: bounds.width, height: barHeight))
        context.fillPath()

        // Drawing strings from the bar to the balls
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineWidth(2)  // Set the string thickness

        for ball in balls {
            let ballTopCenter = CGPoint(x: ball.center.x, y: ball.frame.minY)
            let barAttachmentPoint = CGPoint(x: ball.center.x, y: barYPosition + barHeight)
            
            context.beginPath()
            context.move(to: barAttachmentPoint)
            context.addLine(to: ballTopCenter)
            context.strokePath()  // Draw each string individually for accurate motion
        }

        // Drawing connections and attachment dots for existing animations
        for ball in balls {
            guard let attachmentBehavior = ballsToAttachmentBehaviors[ball] else { continue }
            let anchorPoint = attachmentBehavior.anchorPoint
            
            context.setLineWidth(4.0)
            context.setStrokeColor(UIColor.darkGray.cgColor)
            context.beginPath()
            context.move(to: CGPoint(x: anchorPoint.x, y: anchorPoint.y))
            context.addLine(to: CGPoint(x: ball.center.x, y: ball.center.y))
            context.strokePath()
            
            let attachmentDotWidth: CGFloat = 10.0
            let attachmentDotOrigin = CGPoint(x: anchorPoint.x - (attachmentDotWidth / 2), y: anchorPoint.y - (attachmentDotWidth / 2))
            let attachmentDotRect = CGRect(x: attachmentDotOrigin.x, y: attachmentDotOrigin.y, width: attachmentDotWidth, height: attachmentDotWidth)
            
            context.setFillColor(UIColor.darkGray.cgColor)
            context.fillEllipse(in: attachmentDotRect)
        }

        context.restoreGState()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

