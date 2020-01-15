//
//  MessageCell.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    @IBOutlet var messageContentView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
//    @IBOutlet weak var messageView: UIView!
//    @IBOutlet weak var dateView: UIView!
//    @IBOutlet weak var leftDate: UILabel!
//    @IBOutlet weak var rightDate: UILabel!
    
    var incomeColorBubble =  UIColor(red :0.24, green: 0.57, blue: 0.84, alpha: 1)
    var outComeColorBubble = UIColor(red :0.24, green: 0.57, blue: 0.84, alpha: 0.1)
    
    var incomeColorMessageText = UIColor.white
    var outcomeColorMessageText = UIColor.black
    
    var message: Message!
    
    let dateFormatter = DateFormatter()
    
    func fillCell(message: Message) {
        
        self.message = message
        
        self.messageLabel.font = UIFont.systemFont(ofSize: 17)
        self.messageLabel.text = message.text
        
//        if message.chatRole == .mainUser {
//            self.leftDate.isHidden = true
//            self.rightDate.isHidden = false
//            self.rightDate.text = dateFormatter.string(from: message.date!)
//        } else {
//            self.leftDate.isHidden = false
//            self.rightDate.isHidden = true
//            self.leftDate.text = dateFormatter.string(from: message.date!)
//        }
        
        installViews()
    }
    
    private func installViews() {
        self.messageContentView.layer.cornerRadius = 17
        self.messageContentView.backgroundColor = message.chatRole == .outgoing ? outComeColorBubble : incomeColorBubble
        self.messageLabel.textColor = message.chatRole == .outgoing ? outcomeColorMessageText : incomeColorMessageText
    }
    
}
