//
//  MessageLibController.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

class MessageLibController: UIViewController {
    
    @IBOutlet weak var messageCollectionView: MessageCollectionView!
    @IBOutlet weak var messageTopBar: MessageTopBar!
    @IBOutlet weak var messageBottomBar: MessageBottomBar!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTopBarSeparator: UIView!
    @IBOutlet weak var messageBottomBarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarTopConstraint: NSLayoutConstraint!
    
    private var messagesArray = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let message1 = Message(images: nil, text: "Привет, как у тебя дела?", date: Date(), chatRole: .outgoing)
        let message2 = Message(images: nil, text: "Чего молчишь?", date: Date(), chatRole: .outgoing)

        let message3 = Message(images: nil, text: "Нормас кста)))", date: Date(), chatRole: .incoming)
        let message4 = Message(images: nil, text: "Понимейшен", date: Date(), chatRole: .outgoing)

        messagesArray.append(message1)
        messagesArray.append(message2)
        messagesArray.append(message3)
        messagesArray.append(message4)
        messagesArray.append(message4)
        messagesArray.append(message4)
        messagesArray.append(message4)
        messagesArray.append(message4)
        messagesArray.append(message4)
        messagesArray.append(message4)
        messagesArray.append(message4)
        messagesArray.append(message4)

        installViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        subscribeToNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        unsubcribeNotifications()
    }

    private func installViews() {
//        topBarTopConstraint.constant = MessageHelper.isDeviceHaveBrow() ? -24 : 0
//        topBarHeightConstraint.constant = MessageHelper.isDeviceHaveBrow() ? 88 : 64
        messageCollectionView.delegate = self
        messageCollectionView.dataSource = self
        let messageLibLayout = MessageLibLayout()
        messageLibLayout.delegate = self
        messageCollectionView.collectionViewLayout = messageLibLayout
        messageSend()
    }
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
       
    private func unsubcribeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Foundation.Notification) {
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        messageBottomBarBottomConstraint.constant = keyboardSize.height
    }
    
    @objc func keyboardWillHide(_ notification: Foundation.Notification) {
        messageBottomBarBottomConstraint.constant = 0
        if self.messageBottomBar.textView.text.isEmpty {
//            self.messageBottomBar.placeholderLabel.isHidden = false
        }
    }
    
}

extension MessageLibController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, MessageLibLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, incomingOrOutgoingMessageAtIndexPath indexPath: IndexPath) -> MessageType {
        return messagesArray[indexPath.row].chatRole
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForMesssageTextAtIndexPath indexPath: IndexPath) -> CGSize {
        let message = self.messagesArray[indexPath.row].text
        let size = CGSize(width: view.bounds.width - 60, height: 8000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: message!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)], context: nil)
        
        return CGSize(width: estimatedFrame.width + 30, height: estimatedFrame.height + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let data = self.messagesArray[indexPath.item]

        cell.fillCell(message: data)
 
        return cell
    }
    
    func messageCollectionView(_ messages: [Message]) {
        self.messagesArray = messages
    }
    
}

extension MessageLibController {
    private func messageSend() {
        self.messageBottomBar.messageDidSend = { [weak self] message in
            self?.messagesArray.append(message)
            let row = (self?.messagesArray.count ?? 0) - 1
            let indexPath = IndexPath(row: row, section: 0)
            (self?.messageCollectionView.collectionViewLayout as! MessageLibLayout).insertToCache(indexPath: indexPath)
            self?.messageCollectionView.insertItems(at: [indexPath])
            self?.messageCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    }
}
