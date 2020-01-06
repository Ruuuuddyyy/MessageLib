//
//  MessageTopBar.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

class MessageTopBar: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var viewForName: UIView!
    @IBOutlet weak var viewForStatus: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var contentWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    /// Setup user name who are you talking to
    @IBOutlet weak var userName: UILabel!
    /// Setup status conversation
    @IBOutlet weak var statusConversation: UILabel!
    /// Setup photo for user who are you talking to
    @IBOutlet weak var userImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        installViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        installViews()
    }
    
    private func installViews() {
        Bundle.main.loadNibNamed("MessageTopBar", owner: self, options: nil)
        addSubview(contentView)
        
        contentWidthConstraint.constant = UIScreen.main.bounds.width
        contentHeightConstraint.constant = MessageHelper.isDeviceHaveBrow() ? 88 : 64
        contentView.frame = self.bounds
        
        self.backButton.setImage(UIImage(named: "backIcon"), for: .normal)
        self.userImage.image = UIImage(named: "photo")
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2
    }
    
}
