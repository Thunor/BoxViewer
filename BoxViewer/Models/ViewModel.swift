//
//  ViewModel.swift
//  BoxViewer
//
//  Created by Eric Freitas on 3/5/23.
//

import Foundation
import SceneKit
import Combine


extension ContentView {
    @MainActor class ContentViewModel: ObservableObject {
        @Published var scnScene = SCNScene()
        @Published var cameraNode = SCNNode()
        @Published var cameraOrbit = SCNNode()
        @Published var ticket: AnyCancellable? = nil
        @Published var sceneView: ScenekitView!
    }
}
