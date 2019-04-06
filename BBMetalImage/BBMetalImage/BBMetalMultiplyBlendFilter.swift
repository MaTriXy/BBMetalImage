//
//  BBMetalMultiplyBlendFilter.swift
//  BBMetalImage
//
//  Created by Kaibo Lu on 4/5/19.
//  Copyright © 2019 Kaibo Lu. All rights reserved.
//

import UIKit

public class BBMetalMultiplyBlendFilter: BBMetalBaseFilter {
    public init() { super.init(kernelFunctionName: "multiplyBlendKernel") }
    override func updateParameters(forComputeCommandEncoder encoder: MTLComputeCommandEncoder) {}
}
