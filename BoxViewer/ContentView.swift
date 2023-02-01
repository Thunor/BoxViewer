//
//  ContentView.swift
//  BoxViewer
//
//  Created by Eric Freitas on 1/31/23.
//

import SwiftUI
import SceneKit

struct ContentView: View {
  let pObj = CelestialBody(position: SCNVector3(x: 0, y: 0, z: 0), eccentricity: 0.2, semiMajAxis: 0.2, inclination: 20.0, lngAscNode: 270.0, argOfPeriapsis: 90.0, trueAnomaly: 45.0)
  let sObj = CelestialBody(position: SCNVector3(x: 0, y: 0, z: 0), eccentricity: 0.2, semiMajAxis: 2.0, inclination: 20.0, lngAscNode: 270.0, argOfPeriapsis: 90.0, trueAnomaly: 45.0)
  
    var body: some View {
      CubeView(pObj: pObj, sObj: sObj)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


