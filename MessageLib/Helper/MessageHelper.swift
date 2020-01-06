//
//  MessageHelper.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

enum Iphones {
    case iPhone5
    case iPhone6
    case iPhonePlus
    case iPhoneX
    case iPhoneXR
    case iPhoneXMax
}

class MessageHelper {
    
    static func isDeviceHaveBrow() -> Bool {
        switch checkIphones() {
        case .iPhoneX: return true
        case .iPhoneXMax: return true
        case .iPhoneXR: return true
        default:
            return false
        }
    }
      
    static func checkIphones() -> Iphones {
        switch UIScreen.main.nativeBounds.height {
        case 1136: return .iPhone5
        case 1334: return .iPhone6
        case 2208: return .iPhonePlus
        case 1920: return .iPhonePlus
        case 2436: return .iPhoneX
        case 2688: return .iPhoneXMax
        case 1792: return .iPhoneXR
        default:
            return .iPhone5
        }
    }
    
}
