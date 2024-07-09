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
    var customMeshes: [MeshTypes: Mesh] = [:]
    
    public func ignite(device: MTLDevice) {
        customMeshes = [
            .Triangle: Triangle_CustomMesh(device),
            .Quad: Quad_CustomMesh(device)
        ]
    }
    
    public func getMesh(_ type: MeshTypes) -> Mesh {
        return customMeshes[type]!
    }
}

protocol Mesh {
    var vertexBuffer: MTLBuffer? { get }
    var vertexCount: Int { get }
    
}

class CustomMesh: Mesh {
    typealias Vertex = VertexLibrary.Vertex
    var vertices: [Vertex] = []
    var vertexBuffer: MTLBuffer? = nil
    var vertexCount: Int {
        return vertices.count
    }
    var device: MTLDevice
    init(_ device: MTLDevice) {
        self.device = device
        createVertices()
        createBuffers()
    }
    func createBuffers() {
        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<VertexLibrary.Vertex>.stride, options: [])
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
