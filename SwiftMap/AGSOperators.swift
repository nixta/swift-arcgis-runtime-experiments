//
//  AGSPrototyping.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/9/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import ArcGIS

protocol Geometry {
    typealias Dimension
}

extension AGSPoint: Geometry {
    typealias Dimension = AGSPoint
}
extension AGSMultipoint: Geometry {
    typealias Dimension = AGSPoint
}
extension AGSPolyline: Geometry {
    typealias Dimension = AGSPolyline
}
extension AGSPolygon: Geometry {
    typealias Dimension = AGSPolygon
}

protocol Expandable {}
protocol Contractible {}
protocol Unionable {}

extension AGSPoint: Expandable, Unionable {}
extension AGSMultipoint: Expandable, Unionable {}
extension AGSPolyline: Expandable, Unionable {}
extension AGSPolygon: Expandable, Contractible, Unionable {}

/// Geometry Comparison Operators
@infix func > (lhs: AGSMultipoint, rhs: AGSMultipoint) -> Bool {
    return lhs.numPoints > rhs.numPoints
}

@infix func > (lhs: AGSPolyline, rhs: AGSPolyline) -> Bool {
    return AGSGeometryEngine().geodesicLengthOfGeometry(lhs, inUnit: AGSSRUnitMeter) > AGSGeometryEngine().geodesicLengthOfGeometry(rhs, inUnit: AGSSRUnitMeter)
}

@infix func > (lhs: AGSPolygon, rhs: AGSPolygon) -> Bool {
    return AGSGeometryEngine().geodesicAreaOfGeometry(lhs, inUnit: AGSAreaUnitsSquareMeters) > AGSGeometryEngine().geodesicAreaOfGeometry(rhs, inUnit: AGSAreaUnitsSquareMeters)
}

@infix func < <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension> (lhs: T, rhs: U) {
    return rhs < lhs
}


@infix func >= (lhs: AGSMultipoint, rhs: AGSMultipoint) -> Bool {
    return lhs.numPoints >= rhs.numPoints
}

@infix func <= (lhs: AGSMultipoint, rhs: AGSMultipoint) -> Bool {
    return lhs.numPoints <= rhs.numPoints
}



/// Union Geometry Operator
@infix func + <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().unionGeometries([lhs as AGSGeometry, rhs as AGSGeometry]) as T
}

@infix func || <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return lhs + rhs
}

@infix func - <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().differenceOfGeometry(lhs, andGeometry: rhs) as T
}


/// Project to Spatial Reference
operator infix >>> {}

@infix func >>> <T: AGSGeometry>(lhs: T, rhs: AGSSpatialReference) -> T {
    return AGSGeometryEngine().projectGeometry(lhs, toSpatialReference: rhs) as T
}


/// Expand or contract a geometry
var expandFactor = 1.1

@postfix func ++<T: AGSGeometry, Expandable>(item: T) -> AGSMutablePolygon {
    var env = item.envelope
    var expansion = ((env.width + env.height) / 2) * expandFactor
    return AGSGeometryEngine().bufferGeometry(item, byDistance: expansion)
}

@postfix func --<T: AGSGeometry, Contractible>(item: T) -> AGSMutablePolygon {
    var env = item.envelope
    var expansion = -((env.width + env.height) / 2) * (1 - 1/expandFactor)
    return AGSGeometryEngine().bufferGeometry(item, byDistance: expansion)
}