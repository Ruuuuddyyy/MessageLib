//
//  MessageCell.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

final class MessageCell: UICollectionViewCell {
    
    private lazy var messageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func fillCell(message: Message) {
        
        self.message = message
        
        messageLabel.text = message.text
        messageContentView.backgroundColor = message.chatRole == .outgoing ? outComeColorBubble : incomeColorBubble
        messageLabel.textColor = message.chatRole == .outgoing ? outcomeColorMessageText : incomeColorMessageText

//        if message.chatRole == .mainUser {
//            self.leftDate.isHidden = true
//            self.rightDate.isHidden = false
//            self.rightDate.text = dateFormatter.string(from: message.date!)
//        } else {
//            self.leftDate.isHidden = false
//            self.rightDate.isHidden = true
//            self.leftDate.text = dateFormatter.string(from: message.date!)
//        }
        
        setupViews()
    }
    
    private func setupViews() {
        
        addSubview(messageContentView)
        addSubview(messageLabel)
        
    }
    
}

extension MessageCell {
    override func layoutSubviews() {
        messageContentView.layer.cornerRadius = 17
    }
}
