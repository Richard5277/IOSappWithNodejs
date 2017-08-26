//
//  MessagesCollectionViewController.swift
//  CREWeekly
//
//  Created by Feihong Zhao on 2017-08-19.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MessagesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var user: User?
    
    var messages = [Message]()
    
    var configurationOK = false
    var isUserLoggedin = false
    
    private var refreshControl: UIRefreshControl?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !configurationOK {
            configureNavigationBar()
            fetchData()
            configurationOK = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isUserLoggedin == false {
            askForLogin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        self.collectionView!.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        refreshControl?.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stop", style: .plain, target: self, action: #selector(stopListeningToServer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(fetchData))
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.backgroundColor = .lightGray
        let message = messages[indexPath.item]
        cell.titleLabel.text = message.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }

    private func configureNavigationBar() {
        navigationItem.title = "CREWeekly"
    }
    
    @objc private func fetchData() {
        print("Refresh Page")
        messages = []
        SocketIOManager.sharedInstance.getAllMessages { (messagesInfo) in
            DispatchQueue.main.async {
                for message in messagesInfo {
                    let singleMessage = Message()
                    singleMessage.author = message["author"] as? String
                    singleMessage.content = message["content"] as? String
                    singleMessage.title = message["title"] as? String
                    singleMessage.date = message["date"] as? String
                    self.messages.append(singleMessage)
                }
                print("All Messages Count: ", self.messages.count)
                self.collectionView?.reloadData()

            }
        }
    }
    
    func stopListeningToServer() {
        print("Stop Listenning So Server")
        SocketIOManager.sharedInstance.closeConnection()
    }
    
    func askForLogin() {
        let alertController = UIAlertController(title:"RichNode", message: "Please Enter your name", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField(configurationHandler: nil)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let textField = alertController.textFields?[0] else {
                self.askForLogin()
                return
            }
            
            self.user?.name = textField.text
//            SocketIOManager.sharedInstance.connectToServerWithUserName(_ userName: self.user?.name, completion)
            
        }
    }

}





















