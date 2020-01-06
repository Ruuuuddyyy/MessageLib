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
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var leftDate: UILabel!
    @IBOutlet weak var rightDate: UILabel!
    
    var incomeColorBubble = UIColor.black
    var outComeColorBubble = UIColor.blue
    var incomeColorMessageText = UIColor.white
    var outcomeColorMessageText = UIColor.white
    var message: Message!
    
    let dateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        loadFromNib()
    }
    
    func fillCell(message: Message) {
        
        self.message = message
        
        self.messageLabel.font = UIFont.systemFont(ofSize: 17)
        self.messageLabel.text = message.text
        
        if message.chatRole == .mainUser {
            self.leftDate.isHidden = true
            self.rightDate.isHidden = false
            self.rightDate.text = dateFormatter.string(from: message.date!)
        } else {
            self.leftDate.isHidden = false
            self.rightDate.isHidden = true
            self.leftDate.text = dateFormatter.string(from: message.date!)
        }
        
        installViews()
    }
    
    func installViews() {
   //     self.messageView.layer.cornerRadius = 14
        self.messageView.backgroundColor = message.chatRole == .mainUser ? outComeColorBubble : incomeColorBubble
        self.messageLabel.textColor = message.chatRole == .mainUser ? outcomeColorMessageText : incomeColorMessageText
    }
    
    private func loadFromNib() {
        Bundle.main.loadNibNamed("MessageCell", owner: self, options: nil)
        addSubview(messageContentView)
    //    contentView.frame = self.bounds
    }
    
}
