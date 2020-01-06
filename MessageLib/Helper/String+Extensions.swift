//
//  String+Extensions.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 06.01.2020.
//  Copyright © 2020 Artem Vlasenko. All rights reserved.
//

import UIKit

extension String {
    func SizeOf_String( font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)  // for Single Line
       return size;
   }
}
