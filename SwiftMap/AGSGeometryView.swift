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
    
    func updatePath() {
        if let gl = geometryLayer? {
            if let g = geometry? {
                let targetBounds = CGRectInset(geometryLayer.bounds, geometryLayer.lineWidth/2, geometryLayer.lineWidth/2)
                
                var p:UIBezierPath?
                
                switch g {
                case let g where g as? AGSPoint:
                    println("Got a point")
                case let g where g as? AGSPolyline:
                    let line = g as AGSPolyline
                    p = line.bezier()
                case let g where g as? AGSPolygon:
                    let poly = g as AGSPolygon
                    p = poly.bezierForFrame(targetBounds)
                default:
                    println("What happened here?")
                }
            
                if let p = p? {
                    geometryLayer.path = p.CGPath
                    path = p
                } else {
                    path = nil
                }
            }
        }
    }
    
    override func prepareForInterfaceBuilder()  {
        if !geometry {
            geometry = makeIBGeom()
        }
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
        if let p = path? {
            return p.containsPoint(point)
        }
        return false
    }
}