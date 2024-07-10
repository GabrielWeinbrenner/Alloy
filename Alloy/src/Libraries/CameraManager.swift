//
//  CameraManager.swift
//  Alloy
//
//  Created by Gabriel Weinbrenner on 7/10/24.
//

class CameraManager {
    private var cameras: [CameraType: Camera?] = [:]
    
    public var currentCamera: Camera?
    
    public func registerCamera(camera: Camera) {
        self.cameras.updateValue(camera, forKey: camera.cameraType)
    }
    
    public func setCamera(_ cameraType: CameraType) {
        self.currentCamera = cameras[cameraType]!
    }
    
    internal func update(_ deltaTime: Float) {
        for camera in cameras.values {
            if let camera = camera {
                camera.update(deltaTime)
            }
        }
    }
}
