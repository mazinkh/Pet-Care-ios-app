//
//  CustomSplashView.swift
//  Pet Care
//


import UIKit

class CustomSplashView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black // Set the background color to black
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let circleRadius = min(rect.width, rect.height) * 0.2 // White circle radius

       
        context.setFillColor(UIColor.white.cgColor)
        let circleFrame = CGRect(x: center.x - circleRadius, y: center.y - circleRadius, width: 2 * circleRadius, height: 2 * circleRadius)
        context.addEllipse(in: circleFrame)
        context.fillPath()

        drawPaw(in: context, center: center, size: circleRadius)
    }

    private func drawPaw(in context: CGContext, center: CGPoint, size: CGFloat) {
        let mainPawRadius = size * 0.4 // Size of the main (largest) paw circle
        let smallPawRadius = size * 0.2  // Size of the smaller paw circles

        // Main larger green circle
        let mainPawCenter = CGPoint(x: center.x, y: center.y + size * 0.2)
        context.setFillColor(UIColor.green.cgColor)
        context.addEllipse(in: CGRect(x: mainPawCenter.x - mainPawRadius, y: mainPawCenter.y - mainPawRadius, width: 2 * mainPawRadius, height: 2 * mainPawRadius))
        context.fillPath()

        // Positions of the smaller paw circles
        let offsets = [(-0.7, -0.7), (0.7, -0.7), (0, -1.1)]  
        for (dx, dy) in offsets {
            let offsetX = CGFloat(dx) * mainPawRadius * 1.6
            let offsetY = CGFloat(dy) * mainPawRadius * 1.6
            let smallPawCenter = CGPoint(x: mainPawCenter.x + offsetX, y: mainPawCenter.y + offsetY)
            context.addEllipse(in: CGRect(x: smallPawCenter.x - smallPawRadius, y: smallPawCenter.y - smallPawRadius, width: 2 * smallPawRadius, height: 2 * smallPawRadius))
            context.fillPath()
        }
    }
}

