//
//  AGSOperators.swift
//  SwiftTestbed
//
//  Created by Nicholas Furness on 6/9/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//


/// "Bitwise" Geometry Operators (|, &, ^)
public func | <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().unionGeometries([lhs, rhs]) as T
}

public func & <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().intersectionOfGeometry(lhs, andGeometry: rhs) as T
}

public func ^ <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().symmetricDifferenceOfGeometry(lhs, andGeometry: rhs) as T
}


/// "Arithmetic" Geometry Operators (-, +)
public func - <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return AGSGeometryEngine().differenceOfGeometry(lhs, andGeometry: rhs) as T
}

public func + <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return lhs | rhs
}

/// Project to Spatial Reference
infix operator >> {}

public func >> <T: AGSGeometry>(lhs: T, rhs: AGSSpatialReference) -> T {
    return AGSGeometryEngine().projectGeometry(lhs, toSpatialReference: rhs) as T
}



/// "Logical" Geometry Operators (||, &&)
public func || <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return lhs | rhs
}

public func && <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(lhs: T, rhs: U) -> T {
    return lhs & rhs
}


/// Assignment Operators (+=, -=)
public func += <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(inout lhs: T, rhs: U) {
    lhs = lhs + rhs
}

public func -= <T: AGSGeometry, U: AGSGeometry where T: Geometry, U: Geometry, T.Dimension == U.Dimension>(inout lhs: T, rhs: U) {
    lhs = lhs - rhs
}


/// Geometry Operator protocols - necessary to limit generics
@objc public protocol Geometry {
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
