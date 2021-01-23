//
//  UIImageView+Extension.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2020/12/30.
//

import Nuke

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = UIImage(systemName: "photo")
            return
        }
        let options = ImageLoadingOptions(
            placeholder: UIImage(systemName: "photo"),
            transition: .fadeIn(duration: 0.33),
            failureImage: UIImage(systemName: "photo"),
            failureImageTransition: .fadeIn(duration: 0.33),
            contentModes: .init(success: .scaleAspectFill, failure: .scaleAspectFill, placeholder: .scaleAspectFill)
        )
        Nuke.loadImage(with: url, options: options, into: self)
    }
}

