//
//  VertexLibrary.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//

import MetalKit
enum VertexDescriptorTypes {
    case Basic
}
class VertexLibrary {
    
    var vertexDescriptors: [VertexDescriptorTypes: VertexDescriptor] = [
        .Basic: Basic_VertexDescriptor()
    ]
    struct Vertex {
        var position: SIMD3<Float>
        var color: SIMD4<Float>
    }
    var vertexDescriptor: MTLVertexDescriptor;

    init() {
        vertexDescriptor = vertexDescriptors[.Basic]!.vertexDescriptor
    }
    
    public func getVertexDescriptor(_ type: VertexDescriptorTypes) -> MTLVertexDescriptor {
        vertexDescriptor = vertexDescriptors[type]!.vertexDescriptor
        return vertexDescriptor
    }
    
}

protocol VertexDescriptor {
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor { get }
}

public struct Basic_VertexDescriptor: VertexDescriptor {
    var name: String = "Basic Vertex Descriptor"
    
    var vertexDescriptor: MTLVertexDescriptor {
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3;
        vertexDescriptor.attributes[0].bufferIndex = 0;
        vertexDescriptor.attributes[0].offset = 0;
        
        vertexDescriptor.attributes[1].format = .float4;
        vertexDescriptor.attributes[1].bufferIndex = 0;
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.size;
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<VertexLibrary.Vertex>.stride;
        
        return vertexDescriptor

    }
}
