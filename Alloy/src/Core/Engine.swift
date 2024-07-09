//
//  Engine.swift
//  Alloy
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//
import MetalKit

enum EngineError: Error {
    case deviceNotFound
    case libraryNotFound
    case commandQueueCreationFailed
}

class Engine {
    var device: MTLDevice?
    var commandQueue: MTLCommandQueue?
    
    var vertexLibrary: VertexLibrary
    var shaderLibrary: ShaderLibrary
    var renderLibrary: RenderLibrary
    var renderPipelineLibrary: RenderPipelineLibrary
    var meshLibrary: MeshLibrary
    var sceneManager: SceneManager
    
    public static let shared: Engine = {
        let instance = Engine()
        return instance
    }()

    private init() {
        vertexLibrary = VertexLibrary()
        shaderLibrary = ShaderLibrary()
        renderLibrary = RenderLibrary()
        renderPipelineLibrary = RenderPipelineLibrary()
        meshLibrary = MeshLibrary()
        sceneManager = SceneManager()
    }

    public func Ignite(device: MTLDevice) throws {
        self.device = device
        guard let commandQueue = device.makeCommandQueue() else {
            throw EngineError.commandQueueCreationFailed
        }
        self.commandQueue = commandQueue
        
        guard let library = device.makeDefaultLibrary() else {
            throw EngineError.libraryNotFound
        }

        // Initialize the components with potential errors handled
        do {
            try self.vertexLibrary.ignite()
            try self.shaderLibrary.ignite(defaultLibrary: library)
            try self.renderLibrary.ignite(shaderLibrary: self.shaderLibrary, vertexLibrary: self.vertexLibrary)
            try self.renderPipelineLibrary.ignite(device: device, renderLibrary: self.renderLibrary)
            try self.meshLibrary.ignite(device: device)
            try self.sceneManager.ignite()
            print("Ignite Success")
        } catch {
            throw error
        }
    }
}
