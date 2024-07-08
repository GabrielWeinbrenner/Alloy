//
//  Engine.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//
import MetalKit

class Engine {
    public static var device: MTLDevice!
    public static var commandQueue: MTLCommandQueue!;
    public static var vertexLibrary: VertexLibrary = VertexLibrary()
    public static var shaderLibrary: ShaderLibrary = ShaderLibrary()
    public static var renderLibrary: RenderLibrary = RenderLibrary()
    public static var renderPipelineLibrary: RenderPipelineLibrary = RenderPipelineLibrary()
    public static var meshLibrary: MeshLibrary = MeshLibrary()


    public static func Ignite(device: MTLDevice) {
        self.device = device;
        self.commandQueue = device.makeCommandQueue();
    }
}
