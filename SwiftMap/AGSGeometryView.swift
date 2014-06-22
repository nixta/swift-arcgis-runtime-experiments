//
//  AGSMapView+IB.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/13/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import QuartzCore
import UIKit
import ArcGIS

@IBDesignable class AGSGeometryView : UIView {
    @IBInspectable var lineWidth: CGFloat = 10.0 {
    didSet { updatePath() }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.blackColor() {
    didSet { updatePath() }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.grayColor() {
    didSet { updatePath() }
    }
    
    var geometryLayer: CAShapeLayer!

    var path: UIBezierPath?
    var geometry: AGSGeometry? {
    didSet { updatePath() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !geometryLayer {
            geometryLayer = CAShapeLayer()
            layer.addSublayer(geometryLayer)
            geometryLayer.frame = layer.bounds
            geometryLayer.lineJoin = kCALineJoinRound
            geometryLayer.lineWidth = lineWidth
            geometryLayer.strokeColor = lineColor.CGColor
            geometryLayer.fillColor = fillColor.CGColor
        }
        
        updatePath()
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
        if let p = path? {
            return p.containsPoint(point)
        }
        return false
    }
    
    func updatePath() {
        if let gl = geometryLayer? {
            if let g = geometry? {
                
                let poly = g as AGSPolygon
                
                let targetBounds = CGRectInset(geometryLayer.bounds, geometryLayer.lineWidth/2, geometryLayer.lineWidth/2)
                
                println("Target Bounds for \(poly) is \(targetBounds)")
                
                var p:UIBezierPath = poly.bezierForFrame(targetBounds)
//            switch g {
//            case let g where g as? AGSPoint:
//                println("Got a point")
//            case let g where g as? AGSPolyline:
//                let line = g as AGSPolyline
//                p = line.bezier()
//            case let g where g as? AGSPolygon:
//                let poly = g as AGSPolygon
//                p = poly.bezierForFrame(geometryLayer.bounds)
//            default:
//                println("What happened here?")
//            }
            
//            if p {
//                p.applyTransform(CGAffineTransformMakeTranslation(geometryLayer.frame.width/2, geometryLayer.frame.height/2))

                geometryLayer.path = p.CGPath
                path = p
//            } else {
//                path = nil
//            }
            }
        }
    }
    
    override func prepareForInterfaceBuilder()  {
        if !geometry {
            geometry = makeIBGeom()
        }
    }
}