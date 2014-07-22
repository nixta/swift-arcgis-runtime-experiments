//
//  ViewController.swift
//  SwiftMap
//
//  Created by Nicholas Furness on 6/20/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import UIKit
import ArcGIS
import AGSGeomUtils

var tileUrl = "http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer"
var statesUrl = "http://services.arcgis.com/P3ePLMYs2RVChkJx/ArcGIS/rest/services/USA_States_Generalized/FeatureServer/0"
var nycZipsUrl = "http://services.arcgis.com/OfH668nDRN7tbJh0/arcgis/rest/services/NYC_ZipCodes/FeatureServer/0"
var zipCodeLayerName = "Zipcodes"

class ViewController: UIViewController, AGSMapViewTouchDelegate, AGSLayerDelegate {
                            
    @IBOutlet var mapView:AGSMapView!
    
    @IBOutlet var geomView:AGSGeometryView!
    
    var selectedGeometries:[AGSGeometry] = []
    var displayPolygon:AGSPolygon?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var basemap = AGSTiledMapServiceLayer(URL: NSURL(string: tileUrl))
        mapView.addMapLayer(basemap, withName: "Basemap")
        basemap.delegate = self
        
        var zipcodes = AGSFeatureLayer(URL: NSURL(string: nycZipsUrl), mode: AGSFeatureLayerModeOnDemand)
        mapView.addMapLayer(zipcodes, withName: zipCodeLayerName)
        zipcodes.delegate = self
        
        mapView.touchDelegate = self
        
        let centerPt = AGSPoint(x: -8233300, y: 4950000, spatialReference: AGSSpatialReference.webMercatorSpatialReference())
        
        mapView.zoomToScale(600000, withCenterPoint: centerPt, animated: true)
    }


    
    func mapView(mapView: AGSMapView, didClickAtPoint screen:CGPoint, mapPoint mappoint:AGSPoint, features touchedFeatures:Dictionary<String,[AGSFeature]>) {
        if touchedFeatures[zipCodeLayerName]?.count > 0 {
            self.addOrRemoveFeature(touchedFeatures[zipCodeLayerName]![0])
        }
    }
    
    func addOrRemoveFeature(feature:AGSFeature) {
        if let polygon = feature.geometry? as? AGSPolygon {
            
            if selectedGeometries.count == 0 {
                displayPolygon = polygon
                selectedGeometries += polygon
            } else {
                // Track selected polygons
                var addingPolygon = find(selectedGeometries, polygon) == nil
                if addingPolygon  {
                    selectedGeometries += polygon
                } else {
                    selectedGeometries -= polygon // Using custom -= operator on Array
                }
                
                // Update visible geometry with the current change
                if var workingPolygon = displayPolygon? {
                    
                    if addingPolygon {
                        workingPolygon += polygon
                    } else {
                        workingPolygon -= polygon
                    }

                    displayPolygon = workingPolygon
                }
            }

            geomView.geometry = displayPolygon
        }
    }
    
    
    func layer(layer: AGSLayer, didFailToLoadWithError error:NSError) {
        UIAlertView(title: "Unable to load layer", message: "Layer \(layer.name) could not be loaded: \(error.localizedDescription)", delegate: nil, cancelButtonTitle: "OK").show()
        println("Layer \(layer.name) failed to load with error \(error.localizedDescription)")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

@assignment func -=<T:Equatable>(inout lhs: [T], rhs: T) {
    if let index = find(lhs, rhs) {
        lhs.removeAtIndex(index)
    }
}
