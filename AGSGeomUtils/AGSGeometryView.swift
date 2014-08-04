//
//  AGSGeometryView.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/13/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import QuartzCore

@IBDesignable public class AGSGeometryView : UIView {
    @IBInspectable public var lineWidth: CGFloat = 10.0 { didSet { updatePath() } }
    @IBInspectable public var lineColor: UIColor = UIColor.blackColor() { didSet { updatePath() } }
    @IBInspectable public var fillColor: UIColor = UIColor.grayColor() { didSet { updatePath() } }
    @IBInspectable public var geometryTouchOnly: Bool = false
    
    public var geometry: AGSGeometry? {
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
        if geometryLayer { // Need this because NIB hydration will set values on initialized object
            if let bezierProvider = geometry as? HasBezier {
                let inset = geometryLayer.lineWidth/2
                path = UIBezierPath(geometry: bezierProvider, frame: CGRectInset(geometryLayer.bounds, inset, inset))
            } else {
                path = nil
            }
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        // Create a CAShapeLayer - needs to be here for IBDesignable to work
        if !geometryLayer {
            geometryLayer = CAShapeLayer()
            layer.addSublayer(geometryLayer)
        }
        
        // Initialize the CAShapeLayer for the geometry representation
        if let geometryLayer = geometryLayer {
            geometryLayer.frame = layer.bounds
            geometryLayer.lineJoin = kCALineJoinRound
            geometryLayer.lineWidth = abs(lineWidth)
            geometryLayer.strokeColor = lineColor.CGColor
            geometryLayer.fillColor = fillColor.CGColor
        }

        // Set the bezier path if we have a geometry to show
        updatePath()
    }
    
    override public func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
        if geometryTouchOnly {
            // Only handle clicks within the geometry's outline
            if let p = path? {
                return p.containsPoint(point)
            }
            return false
        }
        return true
    }
    
    override public func prepareForInterfaceBuilder()  {
        if geometry == nil {
            geometry = makeIBGeom()
        }
    }
}
