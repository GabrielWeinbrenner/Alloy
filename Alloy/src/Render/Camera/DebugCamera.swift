//
//  DebugCamera.swift
//  Alloy
//
//  Created by Gabriel Weinbrenner on 7/10/24.
//

class DebugCamera: Camera {
    var cameraType: CameraType = .Debug
    
    var position: SIMD3<Float> = .zero
    
    func update(_ deltaTime: Float) {
        if(Keyboard.IsKeyPressed(.leftArrow)) {
            self.position.x -= deltaTime
        }
        if(Keyboard.IsKeyPressed(.rightArrow)) {
            self.position.x += deltaTime
        }
        if(Keyboard.IsKeyPressed(.upArrow)) {
            self.position.y += deltaTime
        }
        if(Keyboard.IsKeyPressed(.downArrow)) {
            self.position.y -= deltaTime
        }
    }
    
    
}
