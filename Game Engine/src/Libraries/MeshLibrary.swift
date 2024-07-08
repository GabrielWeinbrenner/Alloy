//
//  MeshLibrary.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//

import MetalKit

enum MeshTypes {
    case Triangle
    case Quad
}

class MeshLibrary {
    
    var customMeshes: [MeshTypes: Mesh] = [
        .Triangle: Triangle_CustomMesh(),
        .Quad: Quad_CustomMesh()
    ]
    
    var currentMesh: Mesh
    
    init() {
        currentMesh = customMeshes[.Triangle]!
    }
    
    public func getMesh(_ type: MeshTypes) -> Mesh {
        currentMesh = customMeshes[type]!
        return currentMesh
    }
}

protocol Mesh {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
    
}

class CustomMesh: Mesh {
    typealias Vertex = VertexLibrary.Vertex
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int! {
        return vertices.count
    }
    init() {
        createVertices()
        createBuffers()
    }
    func createBuffers() {
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<VertexLibrary.Vertex>.stride, options: [])
    }
    
    func createVertices() { }
}

class Triangle_CustomMesh: CustomMesh {
    override func createVertices() {
        self.vertices = [
            Vertex(position: SIMD3<Float>(0, 1, 0), color: SIMD4(1, 0, 0, 1)),
            Vertex(position: SIMD3<Float>(-1, -1, 0), color: SIMD4(0, 1, 0, 1)),
            Vertex(position: SIMD3<Float>(1, -1, 0), color: SIMD4(0, 0, 1, 1)),
        ]
    }
}

class Quad_CustomMesh: CustomMesh {
    override func createVertices() {
        self.vertices = [
            Vertex(position: SIMD3<Float>(0.5, 0.5, 0), color: SIMD4(1, 0, 0, 1)),
            Vertex(position: SIMD3<Float>(-0.5, 0.5, 0), color: SIMD4(0, 1, 0, 1)),
            Vertex(position: SIMD3<Float>(-0.5, -0.5, 0), color: SIMD4(0, 0, 1, 1)),
            
            Vertex(position: SIMD3<Float>(0.5, 0.5, 0), color: SIMD4(1, 0, 0, 1)),
            Vertex(position: SIMD3<Float>(-0.5, -0.5, 0), color: SIMD4(0, 0, 1, 1)),
            Vertex(position: SIMD3<Float>(0.5, -0.5, 0), color: SIMD4(1, 0, 1, 1)),
        ]
    }
}
