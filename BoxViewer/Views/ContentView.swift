//
//  ContentView.swift
//  BoxViewer
//
//  Created by Eric Freitas on 1/31/23.
//

import SwiftUI
import SceneKit

struct ContentView: View {
  
  @StateObject private var vm: ContentViewModel
  
  public init() {
    self._vm = StateObject(wrappedValue: ContentViewModel())
  }
  
  // in a multi-star system, the binary pairs will have some special properties:
  // They share the same inclination, argOfPeriapsis & longitude of ascending node.
  // The trueAnomaly is separated by 180 degrees.
  // The eccentrity will change depending on the relative sizes of the stars.
  // I need to come up with a function to determine that amount.
  //
  
  var body: some View {
    ZStack {
      ObjectView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


