//
//  XMPPController.swift
//  CrazyMessages
//
//  Created by Andres on 7/21/16.
//  Copyright © 2016 Andres. All rights reserved.
//

import Foundation
import XMPPFramework

enum XMPPControllerError: Error {
	case wrongUserJID
}

class XMPPController: NSObject {
	var xmppStream: XMPPStream
	
	let hostName: String
	let userJID: XMPPJID
	let hostPort: UInt16
	let password: String
	
	init(hostName: String, userJIDString: String, hostPort: UInt16 = 5222, password: String) throws {
        guard let userJID = XMPPJID(string: userJIDString) else {
			throw XMPPControllerError.wrongUserJID
		}
		
		self.hostName = hostName
		self.userJID = userJID
		self.hostPort = hostPort
		self.password = password
		
		// Stream Configuration
		self.xmppStream = XMPPStream()
		self.xmppStream.hostName = hostName
		self.xmppStream.hostPort = hostPort
		self.xmppStream.startTLSPolicy = XMPPStreamStartTLSPolicy.allowed
		self.xmppStream.myJID = userJID
		
		super.init()
		
		self.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
	}
	
	func connect() {
		if !self.xmppStream.isDisconnected() {
			return
		}

        try! self.xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
	}
}

extension XMPPController: XMPPStreamDelegate {
	
	func xmppStreamDidConnect(_ stream: XMPPStream!) {
		print("Stream: Connected")
		try! stream.authenticate(withPassword: self.password)
	}
	
	func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
		self.xmppStream.send(XMPPPresence())
		print("Stream: Authenticated")
	}
	
	func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
		print("Stream: Fail to Authenticate")
	}
}
