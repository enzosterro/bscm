//
//  DictionaryConstructor.swift
//  BackstopJS SC
//
//  Created by Enzo Sterro on 01.07.16.
//  Copyright © 2016 Enzo Sterro. All rights reserved.
//

import Foundation

struct DictionaryConstructor {

	static func construct(_ dcViewPorts: [[String: AnyObject]],
                   dcScenarios: [[String: AnyObject]],
                   dcPaths: [String: String],
                   dcEngine: String,
                   dcReport: [String],
                   dcCasperFlags: [String],
                   dcDebug: Bool,
                   dcPort: Int) -> [String: Any] {

        return ["viewports": dcViewPorts as AnyObject,
                "scenarios": dcScenarios as AnyObject,
                "paths": dcPaths as AnyObject,
                "engine": dcEngine as AnyObject,
                "report": dcReport as AnyObject,
                "casperFlags": dcCasperFlags as AnyObject,
                "debug": dcDebug as AnyObject,
                "port": dcPort]

    }
}
