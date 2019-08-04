//
//  UIImageExt.swift
//  AnimeLister
//
//  Created by Michael Craun on 8/2/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

extension UIImage {
    func withVerticallyFlippedOrientation() -> UIImage? {
        guard let cgImage = cgImage else { return self }
        return UIImage(cgImage: cgImage, scale: self.scale, orientation: .downMirrored)
    }
}
