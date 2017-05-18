//
//  PathsConstructor.swift
//  BackstopJS SC
//
//  Created by Enzo Sterro on 17.05.2017.
//  Copyright © 2017 Enzo Sterro. All rights reserved.
//

import Foundation

struct PathsConstructor {

	static func construct(pcBitmapsReference: String,
	                      pcBitmapsTest: String,
	                      pcCompareData: String,
	                      pcCasperScripts: String) -> [String: String] {

		return ["bitmaps_reference": pcBitmapsReference,
		        "bitmaps_test": pcBitmapsTest,
		        "compare_data": pcCompareData,
		        "casper_scripts": pcCasperScripts]
	}
	
}
