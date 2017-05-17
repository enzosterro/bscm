//
//  ScenariosConstructor.swift
//  BackstopJS SC
//
//  Created by Enzo Sterro on 17.05.2017.
//  Copyright © 2017 Enzo Sterro. All rights reserved.
//

import Foundation

struct ScenariosConstructor {

	func constructScenario(_ scLabel: String,
	                       scUrl: String,
	                       scHideSelectors: String,
	                       scRemoveSelectors: String,
	                       scSelectors: String,
	                       scReadyEvent: String,
	                       scDelay: Int,
	                       scMisMatchThreshold: Double,
	                       scOnBeforeScript: String,
	                       scOnReadyScript: String) -> [String: Any] {

		return ["label": scLabel as AnyObject,
		        "url": scUrl as AnyObject,
		        "hideSelectors": [scHideSelectors],
		        "removeSelectors": [scRemoveSelectors],
		        "selectors": [scSelectors],
		        "readyEvent": scReadyEvent,
		        "delay": scDelay,
		        "misMatchThreshold": scMisMatchThreshold,
		        "onBeforeScript": scOnBeforeScript,
		        "onReadyScript": scOnReadyScript]
	}

}
