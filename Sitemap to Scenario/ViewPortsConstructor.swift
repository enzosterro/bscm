//
//  ViewPortsConstructor.swift
//  BackstopJS SC
//
//  Created by Enzo Sterro on 17.05.2017.
//  Copyright © 2017 Enzo Sterro. All rights reserved.
//

import Foundation

struct ViewPortsConstructor {

	static func construct(_ vpName: String, vpWidth: Int, vpPortHeight: Int) -> [String: AnyObject] {
		return ["name": vpName as AnyObject, "width": vpWidth as AnyObject, "height": vpPortHeight as AnyObject]
	}

}
