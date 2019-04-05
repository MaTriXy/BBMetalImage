//
//  UIImage+Filter.swift
//  BBMetalImage
//
//  Created by Kaibo Lu on 4/2/19.
//  Copyright © 2019 Kaibo Lu. All rights reserved.
//

import UIKit

public extension UIImage {
    public func bb_brightnessFiltered(withBrightness brightness: Float = 0) -> UIImage? {
        return filtered(with: BBMetalBrightnessFilter(brightness: brightness))
    }
    
    public func bb_exposureFiltered(withExposure exposure: Float = 0) -> UIImage? {
        return filtered(with: BBMetalExposureFilter(exposure: exposure))
    }
    
    public func bb_contrastFiltered(withContrast contrast: Float = 1) -> UIImage? {
        return filtered(with: BBMetalContrastFilter(contrast: contrast))
    }
    
    public func bb_saturationFiltered(withSaturaton saturation: Float = 1) -> UIImage? {
        return filtered(with: BBMetalSaturationFilter(saturation: saturation))
    }
    
    public func bb_gammaFiltered(withGamma gamma: Float = 1) -> UIImage? {
        return filtered(with: BBMetalGammaFilter(gamma: gamma))
    }
    
    public func bb_rgbaFiltered(withRed red: Float = 1, green: Float = 1, blue: Float = 1, alpha: Float = 1) -> UIImage? {
        return filtered(with: BBMetalRGBAFilter(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    public func bb_hueFiltered(withHue hue: Float = 0) -> UIImage? {
        return filtered(with: BBMetalHueFilter(hue: hue))
    }
    
    public func bb_vibranceFiltered(withVibrance vibrance: Float = 0) -> UIImage? {
        return filtered(with: BBMetalVibranceFilter(vibrance: vibrance))
    }
    
    public func bb_whiteBalanceFiltered(withTemperature temperature: Float = 5000, tint: Float = 0) -> UIImage? {
        return filtered(with: BBMetalWhiteBalanceFilter(temperature: temperature, tint: tint))
    }
    
    public func bb_highlightShadowFiltered(withShadows shadows: Float = 0, highlihgts: Float = 1) -> UIImage? {
        return filtered(with: BBMetalHighlightShadowFilter(shadows: shadows, highlights: highlihgts))
    }
    
    public func bb_HighlightShadowTintFiltered(withShadowTintColor shadowTintColor: BBMetalColor = .red,
                                               shadowTintIntensity: Float = 0,
                                               highlightTintColor: BBMetalColor = .blue,
                                               highlightTintIntensity: Float = 0) -> UIImage? {
        
        return filtered(with: BBMetalHighlightShadowTintFilter(shadowTintColor: shadowTintColor,
                                                               shadowTintIntensity: shadowTintIntensity,
                                                               highlightTintColor: highlightTintColor,
                                                               highlightTintIntensity: highlightTintIntensity))
    }
    
    public func bb_lookupFiltered(withLookupTable lookupTable: MTLTexture, intensity: Float = 1) -> UIImage? {
        return filtered(with: BBMetalLookupFilter(lookupTable: lookupTable, intensity: intensity))
    }
    
    public func bb_colorInversionFiltered() -> UIImage? {
        return filtered(with: BBMetalColorInversionFilter())
    }
    
    public func bb_monochromeFiltered(withColor color: BBMetalColor = .red, intensity: Float = 0) -> UIImage? {
        return filtered(with: BBMetalMonochromeFilter(color: color, intensity: intensity))
    }
    
    public func bb_falseColorFiltered(withFirstColor firstColor: BBMetalColor = .red, secondColor: BBMetalColor = .blue) -> UIImage? {
        return filtered(with: BBMetalFalseColorFilter(firstColor: firstColor, secondColor: secondColor))
    }
    
    public func bb_haseFiltered(withDistance distance: Float = 0, slope: Float = 0) -> UIImage? {
        return filtered(with: BBMetalHazeFilter(distance: distance, slope: slope))
    }
    
    public func bb_luminanceFiltered() -> UIImage? {
        return filtered(with: BBMetalLuminanceFilter())
    }
    
    public func bb_luminanceThresholdFiltered(withThreshold threshold: Float = 0.5) -> UIImage? {
        return filtered(with: BBMetalLuminanceThresholdFilter(threshold: threshold))
    }
    
    public func bb_chromaKeyFiltered(withThresholdSensitivity thresholdSensitivity: Float = 0.4, smoothing: Float = 0.1, colorToReplace: BBMetalColor = .green) -> UIImage? {
        return filtered(with: BBMetalChromaKeyFilter(thresholdSensitivity: thresholdSensitivity, smoothing: smoothing, colorToReplace: colorToReplace))
    }
    
    public func bb_sharpenFiltered(withSharpeness sharpeness: Float = 0) -> UIImage? {
        return filtered(with: BBMetalSharpenFilter(sharpeness: sharpeness))
    }
    
    public func bb_gaussianBlurFiltered(withSigma sigma: Float) -> UIImage? {
        return filtered(with: BBMetalGaussianBlurFilter(sigma: sigma))
    }
    
    public func bb_zoomBlurFiltered(withBlurSize blurSize: Float = 0, blurCenter: BBMetalPosition = .center) -> UIImage? {
        return filtered(with: BBMetalZoomBlurFilter(blurSize: blurSize, blurCenter: blurCenter))
    }
    
    public func bb_motionBlurFiltered(withBlurSize blurSize: Float = 0, blurAngle: Float = 0) -> UIImage? {
        return filtered(with: BBMetalMotionBlurFilter(blurSize: blurSize, blurAngle: blurAngle))
    }
    
    public func bb_normalBlendFiltered(withImage image: UIImage) -> UIImage? {
        return filtered(with: BBMetalNormalBlendFilter(), image: image)
    }
    
    public func bb_chromaKeyBlendFiltered(withThresholdSensitivity thresholdSensitivity: Float = 0.4,
                                          smoothing: Float = 0.1,
                                          colorToReplace: BBMetalColor = .green,
                                          image: UIImage) -> UIImage? {
        
        return filtered(with: BBMetalChromaKeyBlendFilter(thresholdSensitivity: thresholdSensitivity,
                                                          smoothing: smoothing,
                                                          colorToReplace: colorToReplace),
                        image: image)
    }
    
    private func filtered(with filter: BBMetalBaseFilter, image: UIImage...) -> UIImage? {
        filter.runSynchronously = true
        let sources = ([self] + image).map { BBMetalStaticImageSource(image: $0) }
        for source in sources { source.add(consumer: filter) }
        for source in sources { source.transmitTexture() }
        return filter.outputTexture?.bb_image
    }
}