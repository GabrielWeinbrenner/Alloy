//
//  Math.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/9/24.
//

import MetalKit

extension matrix_float4x4 {
    mutating func translate(by vec: SIMD3<Float>) {
        let translationMatrix = matrix_float4x4(columns: (
            SIMD4<Float>(1, 0, 0, 0),
            SIMD4<Float>(0, 1, 0, 0),
            SIMD4<Float>(0, 0, 1, 0),
            SIMD4<Float>(vec.x, vec.y, vec.z, 1)
        ))

        self = matrix_multiply(self, translationMatrix)
    }
    
    mutating func scale(by vec: SIMD3<Float>) {
        let translationMatrix = matrix_float4x4(columns: (
            SIMD4<Float>(vec.x, 0, 0, 0),
            SIMD4<Float>(0, vec.y, 0, 0),
            SIMD4<Float>(0, 0, vec.z, 0),
            SIMD4<Float>(0, 0, 0, 1)
        ))
        self = matrix_multiply(self, translationMatrix)
    }
    
    mutating func rotate(by angle: Float, axis: SIMD3<Float>) {
        let normalizedAxis = normalize(axis)
        let x = normalizedAxis.x
        let y = normalizedAxis.y
        let z = normalizedAxis.z
        
        let cosAngle = cos(angle)
        let sinAngle = sin(angle)
        
        let rotationMatrix = matrix_float4x4(columns: (
            SIMD4<Float>(
                cosAngle + (1 - cosAngle) * x * x,
                (1 - cosAngle) * x * y - sinAngle * z,
                (1 - cosAngle) * x * z + sinAngle * y,
                0
            ),
            SIMD4<Float>(
                (1 - cosAngle) * y * x + sinAngle * z,
                cosAngle + (1 - cosAngle) * y * y,
                (1 - cosAngle) * y * z - sinAngle * x,
                0
            ),
            SIMD4<Float>(
                (1 - cosAngle) * z * x - sinAngle * y,
                (1 - cosAngle) * z * y + sinAngle * x,
                cosAngle + (1 - cosAngle) * z * z,
                0
            ),
            SIMD4<Float>(0, 0, 0, 1)
        ))
        
        self = matrix_multiply(self, rotationMatrix)
    }

}
