//
//  Message.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

enum ChatRole {
    case mainUser
    case minorUser
}

struct Message {
    
    var images: [UIImage]?
    var text: String?
    var date: Date?
    var chatRole = ChatRole.mainUser

}
