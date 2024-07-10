//
//  Camera.swift
//  Alloy
//
//  Created by Gabriel Weinbrenner on 7/10/24.
//

import MetalKit
enum CameraType {
    case Perspective
    case Orthographic
    case Debug
}
protocol Camera {
    var cameraType: CameraType { get }
    var position: SIMD3<Float> { get set }
    func update(_ deltaTime: Float)
}
extension Camera {
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.translate(by: -position)
        return viewMatrix
    }
}

