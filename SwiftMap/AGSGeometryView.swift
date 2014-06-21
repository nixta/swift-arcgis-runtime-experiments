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

@IBDesignable
class AGSGeometryView : UIView {
    @IBInspectable
    var lineWidth: CGFloat = 10.0 {
    didSet { updateLayerProperties() }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.blackColor() {
    didSet { updateLayerProperties() }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.grayColor() {
    didSet { updateLayerProperties() }
    }
    
    var geometryLayer: CAShapeLayer!
    var path: UIBezierPath?
    var geometry: AGSGeometry? {
    didSet { updateLayerProperties() }
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
        
        updateLayerProperties()
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
        if let p = path? {
            return p.containsPoint(point)
        }
        return false
    }
    
    func updateLayerProperties() {
        if let gl = geometryLayer? {
        if let g = geometry? {
            
            let poly = g as AGSPolygon
            
            let targetBounds = geometryLayer.bounds

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
                p.applyTransform(CGAffineTransformMakeTranslation(geometryLayer.frame.width/2, geometryLayer.frame.height/2))

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
            var newGeom = makeUKGeom()
            geometry = newGeom
        }
    }
    
    var ukCoords: Array<Array<Double>> = [[-3.005005,58.635],
        [-4.073828,57.553025],
        [-3.055002,57.690019],
        [-1.959281,57.6848],
        [-2.219988,56.870017],
        [-3.119003,55.973793],
        [-2.085009,55.909998],
        [-2.005676,55.804903],
        [-1.114991,54.624986],
        [-0.430485,54.464376],
        [0.184981,53.325014],
        [0.469977,52.929999],
        [1.681531,52.73952],
        [1.559988,52.099998],
        [1.050562,51.806761],
        [1.449865,51.289428],
        [0.550334,50.765739],
        [-0.787517,50.774989],
        [-2.489998,50.500019],
        [-2.956274,50.69688],
        [-3.617448,50.228356],
        [-4.542508,50.341837],
        [-5.245023,49.96],
        [-5.776567,50.159678],
        [-4.30999,51.210001],
        [-3.414851,51.426009],
        [-3.422719,51.426848],
        [-4.984367,51.593466],
        [-5.267296,51.9914],
        [-4.222347,52.301356],
        [-4.770013,52.840005],
        [-4.579999,53.495004],
        [-3.093831,53.404547],
        [-3.09208,53.404441],
        [-2.945009,53.985],
        [-3.614701,54.600937],
        [-3.630005,54.615013],
        [-4.844169,54.790971],
        [-5.082527,55.061601],
        [-4.719112,55.508473],
        [-5.047981,55.783986],
        [-5.586398,55.311146],
        [-5.644999,56.275015],
        [-6.149981,56.78501],
        [-5.786825,57.818848],
        [-5.009999,58.630013],
        [-4.211495,58.550845],
        [-3.005005,58.635]]
    
    func makeUKGeom() -> AGSPolygon {
        var ukPolygon = AGSMutablePolygon(spatialReference: AGSSpatialReference.wgs84SpatialReference())
        ukPolygon.addRingToPolygon()
        for coord in ukCoords {
            let x = coord[0]
            let y = coord[1]
            let pt = AGSPoint(x: x, y: y, spatialReference: ukPolygon.spatialReference)
            ukPolygon.addPointToRing(pt)
        }
        return ukPolygon
    }
}