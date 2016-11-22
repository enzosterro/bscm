//
//  DictionaryConstructor.swift
//  Sitemap to Scenario
//
//  Created by Enzo Sterro on 01.07.16.
//  Copyright © 2016 Enzo Sterro. All rights reserved.
//

import Foundation

struct ViewPortsConstructor {
    func constructViewPorts(_ vpName: String, vpWidth: Int, vpPortHeight: Int) -> [String: AnyObject] {
        return ["name": vpName as AnyObject, "width": vpWidth as AnyObject, "height": vpPortHeight as AnyObject]
    }
}

struct ScenariosConstructor {
    func constructScenario(_ scLabel: String, scUrl: String, scHideSelectors: String, scRemoveSelectors: String, scSelectors: String, scReadyEvent: String, scDelay: Int, scMisMatchThreshold: Double, scOnBeforeScript: String, scOnReadyScript: String) -> [String: Any] {
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


struct PathsConstructor {
    
    func constructPaths(_ pcBitmapsReference: String, pcBitmapsTest: String, pcCompareData: String, pcCasperScripts: String) -> [String: String] {
        return ["bitmaps_reference": pcBitmapsReference,
                "bitmaps_test": pcBitmapsTest,
                "compare_data": pcCompareData,
                "casper_scripts": pcCasperScripts]
    }
}

struct DictionaryConstructor {
    func construct(_ dcViewPorts: [NSDictionary], dcScenarios: [[String: AnyObject]], dcPaths: [String: String], dcEngine: String, dcReport: [String], dcCasperFlags: [String], dcDebug: Bool, dcPort: Int) -> [String: Any] {
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
