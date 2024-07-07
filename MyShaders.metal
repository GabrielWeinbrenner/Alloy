//
//  MyShaders.metal
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/7/24.
//

#include <metal_stdlib>
using namespace metal;

vertex float4 basic_vertex_shader() {
    return float4(1);
}

fragment half4 basic_fragment_shader() {
    return half4(1);
}
