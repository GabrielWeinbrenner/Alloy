//
//  Renderable.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//

import MetalKit

protocol Renderable {
    func commitRender(_ renderCommandEncoder: MTLRenderCommandEncoder) throws
}
