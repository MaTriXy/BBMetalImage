//
//  StaticImageFilterVC.swift
//  BBMetalImageDemo
//
//  Created by Kaibo Lu on 4/2/19.
//  Copyright © 2019 Kaibo Lu. All rights reserved.
//

import UIKit
import BBMetalImage

class StaticImageFilterVC: UIViewController {

    private let type: FilterType
    private var image: UIImage!
    
    private var imageView: UIImageView!
    
    init(type: FilterType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image = UIImage(named: "sunflower.jpg")
        
        title = "\(type)"
        view.backgroundColor = .gray
        
        imageView = UIImageView(frame: CGRect(x: 10, y: 100, width: view.bounds.width - 20, height: view.bounds.height - 200))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
        view.addSubview(imageView)
        
        let button = UIButton(frame: CGRect(x: 10, y: view.bounds.height - 90, width: view.bounds.width - 20, height: 30))
        button.backgroundColor = .blue
        button.setTitle("Add filter", for: .normal)
        button.setTitle("Remove filer", for: .selected)
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func clickButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            imageView.image = filteredImage
        } else {
            imageView.image = image
        }
    }
    
    private var filteredImage: UIImage? {
        switch type {
        case .brightness: return image.bb_brightnessFiltered(withBrightness: 0.15)
        case .exposure: return image.bb_exposureFiltered(withExposure: 0.5)
        case .contrast: return image.bb_contrastFiltered(withContrast: 1.5)
        case .saturation: return image.bb_saturationFiltered(withSaturaton: 2)
        case .gamma: return image.bb_gammaFiltered(withGamma: 1.5)
        case .rgba: return image.bb_rgbaFiltered(withRed: 1.2, green: 1, blue: 1, alpha: 1)
        case .hue: return image.bb_hueFiltered(withHue: 90)
        case .vibrance: return image.bb_vibranceFiltered(withVibrance: 1)
        case .whiteBalance: return image.bb_whiteBalanceFiltered(withTemperature: 7000, tint: 0)
        case .highlightShadow: return image.bb_highlightShadowFiltered(withShadows: 0.5, highlihgts: 0.5)
        case .highlightShadowTint: return image.bb_HighlightShadowTintFiltered(withShadowTintColor: .blue,
                                                                               shadowTintIntensity: 0.5,
                                                                               highlightTintColor: .red,
                                                                               highlightTintIntensity: 0.5)
        case .lookup:
            let url = Bundle.main.url(forResource: "test_lookup", withExtension: "png")!
            let data = try! Data(contentsOf: url)
            return image.bb_lookupFiltered(withLookupTable: data.bb_metalTexture!, intensity: 1)
        case .colorInversion: return image.bb_colorInversionFiltered()
        case .monochrome: return image.bb_monochromeFiltered(withColor: BBMetalColor(red: 0.7, green: 0.6, blue: 0.5), intensity: 1)
        case .falseColor: return image.bb_falseColorFiltered(withFirstColor: .red, secondColor: .blue)
        case .haze: return image.bb_haseFiltered(withDistance: 0.2, slope: 0)
        case .luminance: return image.bb_luminanceFiltered()
        case .luminanceThreshold: return image.bb_luminanceThresholdFiltered(withThreshold: 0.6)
        case .chromaKey: return image.bb_chromaKeyFiltered(withThresholdSensitivity: 0.4, smoothing: 0.1, colorToReplace: .blue)
        case .sharpen: return image.bb_sharpenFiltered(withSharpeness: 0.5)
        case .gaussianBlur: return image.bb_gaussianBlurFiltered(withSigma: 3)
        case .zoomBlur: return image.bb_zoomBlurFiltered(withBlurSize: 3, blurCenter: BBMetalPosition(x: 0.35, y: 0.55))
        case .motionBlur: return image.bb_motionBlurFiltered(withBlurSize: 5, blurAngle: 30)
        case .normalBlend: return image.bb_normalBlendFiltered(withImage: topBlendImage)
        case .chromaKeyBlend: return image.bb_chromaKeyBlendFiltered(withThresholdSensitivity: 0.4, smoothing: 0.1, colorToReplace: .blue, image: topBlendImage)
        }
    }
    
    private var topBlendImage: UIImage {
        return UIImage(named: "multicolour_flowers.jpg")!.bb_rgbaFiltered(alpha: 0.1)!
    }
}