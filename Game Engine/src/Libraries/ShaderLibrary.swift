//
//  ShaderLibrary.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//

import Foundation
import MetalKit
enum VertexShaderTypes {
    case Basic
}

enum FragmentShaderTypes {
    case Basic
}

class ShaderLibrary {
    
    var vertexShaders: [VertexShaderTypes: Shader] = [:]
    var fragmentShaders: [FragmentShaderTypes: Shader] = [:]
    
    public func ignite(defaultLibrary: MTLLibrary) {
        vertexShaders = [
            .Basic: Basic_VertexShader(defaultLibrary)
        ]
        fragmentShaders = [
            .Basic: Basic_FragmentShader(defaultLibrary)
        ]
    }
    
    public func vertex(_ vertexShaderType: VertexShaderTypes) -> MTLFunction? {
        return vertexShaders[vertexShaderType]!.function
    }
    public func fragment(_ fragmentShaderType: FragmentShaderTypes) -> MTLFunction? {
        return fragmentShaders[fragmentShaderType]!.function
    }

}

protocol Shader {
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction? { get }
}

public struct Basic_VertexShader: Shader {
    public var name: String = "Basic Vertex Shader"
    public var functionName: String = "basic_vertex_shader"
    public var function: MTLFunction?
    init(_ defaultLibrary: MTLLibrary) {
        let function = defaultLibrary.makeFunction(name: functionName)
        function?.label = name
        self.function = function
    }
    
}
public struct Basic_FragmentShader: Shader {
    public var name: String = "Basic Fragment Shader"
    public var functionName: String = "basic_fragment_shader"
    public var function: MTLFunction?
    init(_ defaultLibrary: MTLLibrary) {
        let function = defaultLibrary.makeFunction(name: functionName)
        function?.label = name
        self.function = function
    }
    
}

