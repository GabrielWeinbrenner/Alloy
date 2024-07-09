//
//  Renderer.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//

import MetalKit

class Renderer: NSObject {
    var player = Player()
    var gameObjects: [Node] = []
    override init() {
        super.init()
        gameObjects.append(player)
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // When the window is resized
    }
    
    func draw(in view: MTKView) {
        // Pass in the view that we're delegating from 
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return; }
        
        let commandBuffer = Engine.commandQueue.makeCommandBuffer();
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        player.update(deltaTime: 1 / Float(view.preferredFramesPerSecond))
        for i in gameObjects {
            i.render(renderCommandEncoder: renderCommandEncoder!)
        }

        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    
}
