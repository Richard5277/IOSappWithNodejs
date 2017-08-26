//
//  SocketIOManager.swift
//  CREWeekly
//
//  Created by Feihong Zhao on 2017-08-19.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SocketIO

//typealias getAllMessageConpletionHandler = ([[String: AnyObject]]?) -> Void

class SocketIOManager: NSObject {
    
    static let sharedInstance = SocketIOManager()
    
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: "http://localhost:8080")!)
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func connectToServerWithUserName(_ userName: String, completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
        socket.emit("connectUser", userName)
        socket.on("userList") { (dataArray, ack) in
            completionHandler(dataArray[0] as? [[String: AnyObject]])
        }
    }
    
    func getAllMessages(completionHandler: @escaping (_ messages: [[String: AnyObject]]) -> Void) {
        socket.on("allMessages") { (dataArray, socketAck) in
            let data = dataArray[0] as! [[String : AnyObject]]
            completionHandler(data)
            
        }
    }
    
}












