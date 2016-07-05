//
//  DictionaryConstructor.swift
//  Sitemap to Scenario
//
//  Created by Enzo Sterro on 01.07.16.
//  Copyright © 2016 Enzo Sterro. All rights reserved.
//

import Foundation

struct ViewPortsConstructor {
    func constructViewPorts(vpName: String, vpWidth: Int, vpPortHeight: Int) -> [String: AnyObject] {
        return ["name": vpName, "width": vpWidth, "height": vpPortHeight]
    }
}

struct ScenariosConstructor {
    func constructScenario(scLabel: String, scUrl: String, scHideSelectors: String, scRemoveSelectors: String, scSelectors: String, scReadyEvent: String, scDelay: Int, scMisMatchThreshold: Double, scOnBeforeScript: String, scOnReadyScript: String) -> [String: AnyObject] {
        return ["label": scLabel,
                "url": scUrl,
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
    
    func constructPaths(pcBitmapsReference: String, pcBitmapsTest: String, pcCompareData: String, pcCasperScripts: String) -> [String: String] {
        return ["bitmaps_reference": pcBitmapsReference,
                "bitmaps_test": pcBitmapsTest,
                "compare_data": pcCompareData,
                "casper_scripts": pcCasperScripts]
    }
}

struct DictionaryConstructor {
    func construct(dcViewPorts: [NSDictionary], dcScenarios: [[String: AnyObject]], dcPaths: [String: String], dcEngine: String, dcReport: [String], dcCasperFlags: [String], dcDebug: Bool, dcPort: Int) -> [String: AnyObject] {
        return ["viewports": dcViewPorts,
                "scenarios": dcScenarios,
                "paths": dcPaths,
                "engine": dcEngine,
                "report": dcReport,
                "casperFlags": dcCasperFlags,
                "debug": dcDebug,
                "port": dcPort]
    }
}