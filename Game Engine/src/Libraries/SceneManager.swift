//
//  SceneManager.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/9/24.
//
import MetalKit
enum SceneTypes {
    case Sandbox
}
class SceneManager {
    
    var scene: [SceneTypes: Scene] = [:]

    var currentScene: Scene?;

    public func ignite() {
        scene = [
            .Sandbox: Sandbox()
        ]
        currentScene = scene[.Sandbox]!
    }
    
    func tickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) throws {
        guard let currentScene = currentScene else {
            return
        }
        currentScene.update(deltaTime: deltaTime)
        try currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
    
    
}
