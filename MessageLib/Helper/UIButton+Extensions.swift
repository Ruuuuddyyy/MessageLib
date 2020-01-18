//
//  UIButton+Extensions.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 18.01.2020.
//  Copyright © 2020 Artem Vlasenko. All rights reserved.
//

import UIKit

extension UIButton {
    func tapAnimation() {
        UIButton.animate(withDuration: 0.2, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { [weak self] finish in
            UIButton.animate(withDuration: 0.2, animations: {
                self?.transform = CGAffineTransform.identity
            })
        })
    }
}
