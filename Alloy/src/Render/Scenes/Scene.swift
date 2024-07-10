//
//  Scene.swift
//  Alloy
//
//  Created by Gabriel Weinbrenner on 7/9/24.
//

import MetalKit
/**
    SCENE GRAPH LOOKS LIKE A TREE
 */
struct SceneConstants {
    var viewMatrix: matrix_float4x4?
}

class Scene: Node {
    var sceneConstants = SceneConstants()
    var cameraManager = CameraManager()
    override init() {
        super.init()
        buildScene()
    }
    func updateSceneConstants() {
        if let camera = cameraManager.currentCamera {
            sceneConstants.viewMatrix = camera.viewMatrix
        }
    }
    func addCamera(_ camera: Camera, _ isCurrentCamera: Bool = true) {
        cameraManager.registerCamera(camera: camera)
        if(isCurrentCamera) {
            cameraManager.setCamera(camera.cameraType)
        }
    }
    func buildScene() {
        
    }
    
    func updateCamera(_ deltaTime: Float) {
        cameraManager.update(deltaTime)
    }
    
    override func update(_ deltaTime: Float) {
        updateSceneConstants()
        super.update(deltaTime)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) throws {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: MemoryLayout<SceneConstants>.stride, index: 2)
        try super.render(renderCommandEncoder: renderCommandEncoder)
    }
}
