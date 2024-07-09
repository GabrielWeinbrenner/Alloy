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
    
    var scene: [SceneTypes: Scene] = [
        .Sandbox: Sandbox(),
    ]

    var currentScene: Scene;

    init() {
        currentScene = scene[.Sandbox]!
    }
    
    func tickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        currentScene.update(deltaTime: deltaTime)
        currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
    
    
}
