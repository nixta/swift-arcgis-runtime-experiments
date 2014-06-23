//
//  AGSGeometryView_IBGeometries.swift
//  SwiftMap
//
//  Created by Nicholas Furness on 6/22/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import Foundation
import ArcGIS

func makeIBGeom() -> AGSPolygon {
    var ibPolygon = AGSMutablePolygon(spatialReference: AGSSpatialReference.wgs84SpatialReference())
    ibPolygon.addRingToPolygon()
    for coord in nullIslandCoords {
        let x = coord[0]
        let y = coord[1]
        let pt = AGSPoint(x: x, y: y, spatialReference: ibPolygon.spatialReference)
        ibPolygon.addPointToRing(pt)
    }
    return ibPolygon
}

var usaCoords: Array<Array<Double>> = [[-94.81758, 49.38905],
    [-94.64, 48.84],
    [-94.32914, 48.67074],
    [-93.63087, 48.60926],
    [-92.61, 48.45],
    [-91.64, 48.14],
    [-90.83, 48.27],
    [-89.6, 48.01],
    [-89.272917, 48.019808],
    [-88.378114, 48.302918],
    [-87.439793, 47.94],
    [-86.461991, 47.553338],
    [-85.652363, 47.220219],
    [-84.87608, 46.900083],
    [-84.779238, 46.637102],
    [-84.543749, 46.538684],
    [-84.6049, 46.4396],
    [-84.3367, 46.40877],
    [-84.14212, 46.512226],
    [-84.091851, 46.275419],
    [-83.890765, 46.116927],
    [-83.616131, 46.116927],
    [-83.469551, 45.994686],
    [-83.592851, 45.816894],
    [-82.550925, 45.347517],
    [-82.337763, 44.44],
    [-82.137642, 43.571088],
    [-82.43, 42.98],
    [-82.9, 42.43],
    [-83.12, 42.08],
    [-83.142, 41.975681],
    [-83.02981, 41.832796],
    [-82.690089, 41.675105],
    [-82.439278, 41.675105],
    [-81.277747, 42.209026],
    [-80.247448, 42.3662],
    [-78.939362, 42.863611],
    [-78.92, 42.965],
    [-79.01, 43.27],
    [-79.171674, 43.466339],
    [-78.72028, 43.625089],
    [-77.737885, 43.629056],
    [-76.820034, 43.628784],
    [-76.5, 44.018459],
    [-76.375, 44.09631],
    [-75.31821, 44.81645],
    [-74.867, 45.00048],
    [-73.34783, 45.00738],
    [-71.50506, 45.0082],
    [-71.405, 45.255],
    [-71.08482, 45.30524],
    [-70.66, 45.46],
    [-70.305, 45.915],
    [-69.99997, 46.69307],
    [-69.237216, 47.447781],
    [-68.905, 47.185],
    [-68.23444, 47.35486],
    [-67.79046, 47.06636],
    [-67.79134, 45.70281],
    [-67.13741, 45.13753],
    [-66.96466, 44.8097],
    [-68.03252, 44.3252],
    [-69.06, 43.98],
    [-70.11617, 43.68405],
    [-70.645476, 43.090238],
    [-70.81489, 42.8653],
    [-70.825, 42.335],
    [-70.495, 41.805],
    [-70.08, 41.78],
    [-70.185, 42.145],
    [-69.88497, 41.92283],
    [-69.96503, 41.63717],
    [-70.64, 41.475],
    [-71.12039, 41.49445],
    [-71.86, 41.32],
    [-72.295, 41.27],
    [-72.87643, 41.22065],
    [-73.71, 40.931102],
    [-72.24126, 41.11948],
    [-71.945, 40.93],
    [-73.345, 40.63],
    [-73.982, 40.628],
    [-73.952325, 40.75075],
    [-74.25671, 40.47351],
    [-73.96244, 40.42763],
    [-74.17838, 39.70926],
    [-74.90604, 38.93954],
    [-74.98041, 39.1964],
    [-75.20002, 39.24845],
    [-75.52805, 39.4985],
    [-75.32, 38.96],
    [-75.071835, 38.782032],
    [-75.05673, 38.40412],
    [-75.37747, 38.01551],
    [-75.94023, 37.21689],
    [-76.03127, 37.2566],
    [-75.72205, 37.93705],
    [-76.23287, 38.319215],
    [-76.35, 39.15],
    [-76.542725, 38.717615],
    [-76.32933, 38.08326],
    [-76.989998, 38.239992],
    [-76.30162, 37.917945],
    [-76.25874, 36.9664],
    [-75.9718, 36.89726],
    [-75.86804, 36.55125],
    [-75.72749, 35.55074],
    [-76.36318, 34.80854],
    [-77.397635, 34.51201],
    [-78.05496, 33.92547],
    [-78.55435, 33.86133],
    [-79.06067, 33.49395],
    [-79.20357, 33.15839],
    [-80.301325, 32.509355],
    [-80.86498, 32.0333],
    [-81.33629, 31.44049],
    [-81.49042, 30.72999],
    [-81.31371, 30.03552],
    [-80.98, 29.18],
    [-80.535585, 28.47213],
    [-80.53, 28.04],
    [-80.056539, 26.88],
    [-80.088015, 26.205765],
    [-80.13156, 25.816775],
    [-80.38103, 25.20616],
    [-80.68, 25.08],
    [-81.17213, 25.20126],
    [-81.33, 25.64],
    [-81.71, 25.87],
    [-82.24, 26.73],
    [-82.70515, 27.49504],
    [-82.85526, 27.88624],
    [-82.65, 28.55],
    [-82.93, 29.1],
    [-83.70959, 29.93656],
    [-84.1, 30.09],
    [-85.10882, 29.63615],
    [-85.28784, 29.68612],
    [-85.7731, 30.15261],
    [-86.4, 30.4],
    [-87.53036, 30.27433],
    [-88.41782, 30.3849],
    [-89.18049, 30.31598],
    [-89.593831, 30.159994],
    [-89.413735, 29.89419],
    [-89.43, 29.48864],
    [-89.21767, 29.29108],
    [-89.40823, 29.15961],
    [-89.77928, 29.30714],
    [-90.15463, 29.11743],
    [-90.880225, 29.148535],
    [-91.626785, 29.677],
    [-92.49906, 29.5523],
    [-93.22637, 29.78375],
    [-93.84842, 29.71363],
    [-94.69, 29.48],
    [-95.60026, 28.73863],
    [-96.59404, 28.30748],
    [-97.14, 27.83],
    [-97.37, 27.38],
    [-97.38, 26.69],
    [-97.33, 26.21],
    [-97.14, 25.87],
    [-97.53, 25.84],
    [-98.24, 26.06],
    [-99.02, 26.37],
    [-99.3, 26.84],
    [-99.52, 27.54],
    [-100.11, 28.11],
    [-100.45584, 28.69612],
    [-100.9576, 29.38071],
    [-101.6624, 29.7793],
    [-102.48, 29.76],
    [-103.11, 28.97],
    [-103.94, 29.27],
    [-104.45697, 29.57196],
    [-104.70575, 30.12173],
    [-105.03737, 30.64402],
    [-105.63159, 31.08383],
    [-106.1429, 31.39995],
    [-106.50759, 31.75452],
    [-108.24, 31.754854],
    [-108.24194, 31.34222],
    [-109.035, 31.34194],
    [-111.02361, 31.33472],
    [-113.30498, 32.03914],
    [-114.815, 32.52528],
    [-114.72139, 32.72083],
    [-115.99135, 32.61239],
    [-117.12776, 32.53534],
    [-117.295938, 33.046225],
    [-117.944, 33.621236],
    [-118.410602, 33.740909],
    [-118.519895, 34.027782],
    [-119.081, 34.078],
    [-119.438841, 34.348477],
    [-120.36778, 34.44711],
    [-120.62286, 34.60855],
    [-120.74433, 35.15686],
    [-121.71457, 36.16153],
    [-122.54747, 37.55176],
    [-122.51201, 37.78339],
    [-122.95319, 38.11371],
    [-123.7272, 38.95166],
    [-123.86517, 39.76699],
    [-124.39807, 40.3132],
    [-124.17886, 41.14202],
    [-124.2137, 41.99964],
    [-124.53284, 42.76599],
    [-124.14214, 43.70838],
    [-124.020535, 44.615895],
    [-123.89893, 45.52341],
    [-124.079635, 46.86475],
    [-124.39567, 47.72017],
    [-124.68721, 48.184433],
    [-124.566101, 48.379715],
    [-123.12, 48.04],
    [-122.58736, 47.096],
    [-122.34, 47.36],
    [-122.5, 48.18],
    [-122.84, 49],
    [-120, 49],
    [-117.03121, 49],
    [-116.04818, 49],
    [-113, 49],
    [-110.05, 49],
    [-107.05, 49],
    [-104.04826, 48.99986],
    [-100.65, 49],
    [-97.22872, 49.0007],
    [-95.15907, 49],
    [-95.15609, 49.38425],
    [-94.81758, 49.38905]
]

var nullIslandCoords: Array<Array<Double>> = [[-0.01316, 0.02599],
    [-0.01316, 0.02648],
    [-0.01318, 0.02976],
    [-0.01294, 0.03041],
    [-0.00926, 0.03472],
    [-0.00916, 0.03482],
    [-0.0083, 0.03484],
    [-0.00636, 0.0329],
    [-0.00572, 0.03264],
    [-0.0042, 0.03265],
    [-0.0042, 0.03397],
    [-0.0036, 0.03409],
    [-0.00224, 0.0341],
    [-0.00165, 0.03384],
    [0.00203, 0.03016],
    [0.00227, 0.02992],
    [0.00269, 0.02992],
    [0.00293, 0.03016],
    [0.006, 0.03324],
    [0.00706, 0.03369],
    [0.00885, 0.03368],
    [0.00887, 0.03415],
    [0.00887, 0.03772],
    [0.00887, 0.03797],
    [0.00903, 0.03849],
    [0.00972, 0.03829],
    [0.01221, 0.03581],
    [0.01388, 0.03579],
    [0.01593, 0.03784],
    [0.01668, 0.03785],
    [0.02346, 0.03106],
    [0.02438, 0.03067],
    [0.03032, 0.0307],
    [0.03112, 0.03036],
    [0.03303, 0.02844],
    [0.0337, 0.02817],
    [0.03732, 0.02818],
    [0.03791, 0.02759],
    [0.03791, 0.02209],
    [0.03736, 0.02155],
    [0.03469, 0.02155],
    [0.03497, 0.02038],
    [0.0377, 0.01765],
    [0.03837, 0.01737],
    [0.03996, 0.01738],
    [0.04088, 0.01699],
    [0.04459, 0.01326],
    [0.0453, 0.01296],
    [0.04743, 0.01297],
    [0.04807, 0.0127],
    [0.05229, 0.00848],
    [0.05255, 0.00784],
    [0.05255, 0.00302],
    [0.05198, 0.00245],
    [0.04878, 0.00245],
    [0.04791, 0.0021],
    [0.0445, -0.00132],
    [0.04088, -0.00491],
    [0.04058, -0.00567],
    [0.04058, -0.00827],
    [0.04108, -0.00829],
    [0.04243, -0.00828],
    [0.04303, -0.00852],
    [0.0447, -0.01018],
    [0.04496, -0.01083],
    [0.04495, -0.01266],
    [0.04429, -0.0133],
    [0.04305, -0.0133],
    [0.0433, -0.01429],
    [0.0462, -0.01717],
    [0.04657, -0.01807],
    [0.04657, -0.02038],
    [0.047, -0.02042],
    [0.04787, -0.02042],
    [0.04839, -0.02094],
    [0.04839, -0.02123],
    [0.04841, -0.02852],
    [0.04801, -0.0295],
    [0.04411, -0.03338],
    [0.04244, -0.03406],
    [0.03974, -0.03404],
    [0.03906, -0.03378],
    [0.03831, -0.03345],
    [0.03688, -0.03347],
    [0.03685, -0.03387],
    [0.03686, -0.03627],
    [0.03662, -0.03687],
    [0.03512, -0.03838],
    [0.0346, -0.03858],
    [0.03181, -0.03858],
    [0.03132, -0.03806],
    [0.03132, -0.03679],
    [0.02891, -0.03679],
    [0.02891, -0.03745],
    [0.02837, -0.03796],
    [0.02698, -0.03796],
    [0.02643, -0.03781],
    [0.02644, -0.03556],
    [0.02614, -0.03483],
    [0.02323, -0.03194],
    [0.02323, -0.03119],
    [0.02485, -0.0296],
    [0.02509, -0.02905],
    [0.02507, -0.02797],
    [0.02467, -0.02793],
    [0.02222, -0.02794],
    [0.02132, -0.02757],
    [0.01989, -0.02613],
    [0.0199, -0.02516],
    [0.021, -0.02407],
    [0.0213, -0.02376],
    [0.02107, -0.0235],
    [0.02023, -0.02313],
    [0.01777, -0.02315],
    [0.01717, -0.0229],
    [0.01582, -0.02153],
    [0.01532, -0.02131],
    [0.00894, -0.02131],
    [0.00874, -0.02134],
    [0.00885, -0.02162],
    [0.01131, -0.02407],
    [0.01182, -0.02427],
    [0.01395, -0.02427],
    [0.0144, -0.02427],
    [0.01421, -0.02623],
    [0.01131, -0.02913],
    [0.01117, -0.02927],
    [0.01007, -0.02971],
    [0.00858, -0.0297],
    [0.00781, -0.03],
    [0.00541, -0.03244],
    [0.00461, -0.03277],
    [-0.00813, -0.03275],
    [-0.00832, -0.03275],
    [-0.00889, -0.03219],
    [-0.00889, -0.02688],
    [-0.00889, -0.02553],
    [-0.01055, -0.02554],
    [-0.01092, -0.0258],
    [-0.01447, -0.02935],
    [-0.01553, -0.02977],
    [-0.01987, -0.02977],
    [-0.02068, -0.02943],
    [-0.02514, -0.02496],
    [-0.02589, -0.02465],
    [-0.02836, -0.02465],
    [-0.02887, -0.02416],
    [-0.02887, -0.02411],
    [-0.02891, -0.02292],
    [-0.02978, -0.02197],
    [-0.03125, -0.0205],
    [-0.0316, -0.01966],
    [-0.0316, -0.01794],
    [-0.03299, -0.01794],
    [-0.03353, -0.01737],
    [-0.03354, -0.01564],
    [-0.03359, -0.01549],
    [-0.03413, -0.01549],
    [-0.03591, -0.01549],
    [-0.03642, -0.01498],
    [-0.03642, -0.01333],
    [-0.03695, -0.0133],
    [-0.04453, -0.0133],
    [-0.04486, -0.0133],
    [-0.04526, -0.01288],
    [-0.04528, -0.01254],
    [-0.04528, -0.00646],
    [-0.04528, -0.00591],
    [-0.04568, -0.00588],
    [-0.04795, -0.00588],
    [-0.04862, -0.0056],
    [-0.05165, -0.00256],
    [-0.05194, -0.00188],
    [-0.05193, 0.00078],
    [-0.05222, 0.00149],
    [-0.05264, 0.00248],
    [-0.05264, 0.00369],
    [-0.05247, 0.00411],
    [-0.04766, 0.00892],
    [-0.04708, 0.0091],
    [-0.04419, 0.0091],
    [-0.04366, 0.0091],
    [-0.04367, 0.01082],
    [-0.04329, 0.01175],
    [-0.03939, 0.01564],
    [-0.03868, 0.01593],
    [-0.03749, 0.01593],
    [-0.03749, 0.01756],
    [-0.03741, 0.01885],
    [-0.03657, 0.01975],
    [-0.0319, 0.02443],
    [-0.03101, 0.02481],
    [-0.02868, 0.0248],
    [-0.02868, 0.02581],
    [-0.02803, 0.02739],
    [-0.02536, 0.03005],
    [-0.02469, 0.03033],
    [-0.02328, 0.03032],
    [-0.02268, 0.0302],
    [-0.02268, 0.02599],
    [-0.01316, 0.02599]]