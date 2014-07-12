//
//  AGSGeometryView.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/13/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import QuartzCore

@IBDesignable class AGSGeometryView : UIView {
    @IBInspectable var lineWidth: CGFloat = 10.0 { didSet { updatePath() } }
    @IBInspectable var lineColor: UIColor = UIColor.blackColor() { didSet { updatePath() } }
    @IBInspectable var fillColor: UIColor = UIColor.grayColor() { didSet { updatePath() } }
    @IBInspectable var geometryTouchOnly: Bool = false
    
    var geometry: AGSGeometry? {
    didSet {
        updatePath()
    }
    }

    var geometryLayer: CAShapeLayer!
    var path: UIBezierPath? {
    didSet {
        if let p = path {
            geometryLayer.path = p.CGPath
        } else {
            geometryLayer.path = nil
        }
    }
    }
    
    func updatePath() {
        if geometryLayer {
            if let bezierProvider = geometry as? HasBezier {
                path = UIBezierPath(geometry: bezierProvider, frame: CGRectInset(geometryLayer.bounds, geometryLayer.lineWidth/2, geometryLayer.lineWidth/2))
            } else {
                path = nil
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Initialize the CAShapeLayer for the geometry representation
        if !geometryLayer {
            geometryLayer = CAShapeLayer()
            layer.addSublayer(geometryLayer)
            geometryLayer.frame = layer.bounds
            geometryLayer.lineJoin = kCALineJoinRound
            geometryLayer.lineWidth = abs(lineWidth)
            geometryLayer.strokeColor = lineColor.CGColor
            geometryLayer.fillColor = fillColor.CGColor
        }

        // Set the bezier path if we have a geometry to show
        updatePath()
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
        if geometryTouchOnly {
            // Only handle clicks within the geometry's outline
            if let p = path? {
                return p.containsPoint(point)
            }
            return false
        }
        return true
    }
    
    override func prepareForInterfaceBuilder()  {
        if !geometry {
            geometry = makeIBGeom()
        }
    }
}
