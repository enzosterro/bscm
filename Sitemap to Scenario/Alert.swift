//
//  Alert.swift
//  BackstopJS SC
//
//  Created by Enzo Sterro on 17.05.2017.
//  Copyright © 2017 Enzo Sterro. All rights reserved.
//

import Cocoa

struct Alert {

	static func showDialog(withTitle title: String, informativeText text: String, cancelButton: Bool = false) {

		let myPopup = NSAlert()
		myPopup.messageText = title
		myPopup.informativeText = text
		myPopup.alertStyle = .warning
		myPopup.addButton(withTitle: "OK")

		if cancelButton {
			myPopup.addButton(withTitle: "Cancel")
		}

		myPopup.runModal()

	}

}
