//
//  ViewController.swift
//  Sitemap to Scenario
//
//  Created by Enzo Sterro on 28.06.16.
//  Copyright © 2016 Enzo Sterro. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var urlTextField: NSTextField!
    @IBOutlet weak var delayTextField: NSTextField!
    @IBOutlet weak var selectorsTextField: NSTextField!
    @IBOutlet weak var hideSelectorsTextField: NSTextField!
    @IBOutlet weak var removeSelectorsTextField: NSTextField!
    @IBOutlet weak var onBeforeScriptTextField: NSTextField!
    @IBOutlet weak var onReadyScriptTextField: NSTextField!
    @IBOutlet weak var readyEventTextField: NSTextField!
    @IBOutlet weak var misMatchThresholdTextField: NSTextField!
    @IBOutlet weak var bitmapsReferenceTextField: NSTextField!
    @IBOutlet weak var bitmapsTestTextField: NSTextField!
    @IBOutlet weak var compareDataTextField: NSTextField!
    @IBOutlet weak var casperScriptsTextField: NSTextField!
    @IBOutlet weak var casperFlagsTextField: NSTextField!
    @IBOutlet weak var engineTextField: NSTextField!
    @IBOutlet weak var reportTextField: NSTextField!
    @IBOutlet weak var debugComboBox: NSComboBox!
    @IBOutlet weak var portTextField: NSTextField!
    @IBOutlet weak var viewPortPhone: NSButton!
    @IBOutlet weak var viewPortTabletF: NSButton!
    @IBOutlet weak var viewPortTabletV: NSButton!
    @IBOutlet weak var viewPortTabletH: NSButton!
    
    @IBAction func makeScenarioButtonPressed(sender: NSButton) {
        
        var contentOfUrl: String!
        
        if let url = NSURL(string: urlTextField.stringValue) {
            do {
                contentOfUrl = try NSString(contentsOfURL: url, usedEncoding: nil) as String
            } catch let error as NSError {
                print("Couldn't create URL: \(error.localizedDescription)") }
        }
        
        if contentOfUrl.containsString("?xml") {
            let downloadsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.DownloadsDirectory, .UserDomainMask, true).first!
            let downloadsDirectoryPath = NSURL(string: downloadsDirectoryPathString)!
            let jsonFilePath = downloadsDirectoryPath.URLByAppendingPathComponent("backstop.json")
            let fileManager = NSFileManager.defaultManager()
            var isDirectory: ObjCBool = false
            
            if !fileManager.fileExistsAtPath(jsonFilePath.absoluteString, isDirectory: &isDirectory) {
                let created = fileManager.createFileAtPath(jsonFilePath.absoluteString, contents: nil, attributes: nil)
                if created { print("File created") }
                else { print("Couldn't create file for some reason") }
            } else {
                if dialogOKCancel("Attention!", text: "Previous file will be overwritten!", cancelButton: true) {
                let created = fileManager.createFileAtPath(jsonFilePath.absoluteString, contents: nil, attributes: nil)
                if created { print("File created") }
                else { print("Couldn't create file for some reason") }
                }
            }
            
            var jsonData: NSData!
            do {
                let xmlToUrl = xmlToArray(contentOfUrl)
                let dict = makeScenario(xmlToUrl)
                jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
            } catch let error as NSError {
                print("Dictionary to JSON conversion failed: \(error.localizedDescription)")
            }
            
            do {
                if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as? String {
                    
                    // NSJSONSerialization serialization of a string containing forward slashes / is escaped incorrectly that's why you may feel nauseous below.
                    let sReplace = "\""
                    let sString1 = jsonString.stringByReplacingOccurrencesOfString("\\/", withString: "/", options: NSStringCompareOptions.CaseInsensitiveSearch, range:nil)
                    let sString2 = sString1.stringByReplacingOccurrencesOfString("\"\\\"", withString: sReplace, options: NSStringCompareOptions.LiteralSearch, range: nil)
                    let sString3 = sString2.stringByReplacingOccurrencesOfString("\\\"\"", withString: sReplace, options: NSStringCompareOptions.LiteralSearch, range: nil)
                    let sString4 = sString3.stringByReplacingOccurrencesOfString("\\\"", withString: sReplace, options: NSStringCompareOptions.LiteralSearch, range: nil)
                    
                    let file = try NSFileHandle(forWritingToURL: jsonFilePath)
                    let dataToWrite = sString4.dataUsingEncoding(NSUTF8StringEncoding)!
                    file.writeData(dataToWrite)
                    dialogOKCancel("Success!", text: "File \"backstop.json\" successfully stored \nat ~\\Download location.", cancelButton: false)
                    print("JSON data was written to the file successfully!")
                }
            } catch let error as NSError {
                print("Couldn't write to file: \(error.localizedDescription)")
            }
        } else {
            dialogOKCancel("Error", text: "Couldn't find XML data.", cancelButton: false)
        }
    }
    
    func xmlToArray(inXml: String) -> [String] {
        let xml = SWXMLHash.parse(inXml)
        var arrayOfLocs = [String]()
        for elem in xml["urlset"]["url"] {
            let currentUrl = elem["loc"].element!.text!
            let invalidLinkRegex = try! NSRegularExpression(pattern: "(.pdf|.txt|.xml)", options: [])
            let nsString = currentUrl as NSString
            let arrayOfMatches = invalidLinkRegex.matchesInString(currentUrl, options: [], range: NSMakeRange(0, nsString.length))
            let result = arrayOfMatches.map { nsString.substringWithRange($0.range) }
            if result.count == 0 { arrayOfLocs.append(currentUrl) }
        }
        return arrayOfLocs
    }
    
    func makeScenario(arrayOfLinks: [String]) -> [String: AnyObject] {
        var debugStatus: Bool!
        var viewPort = [NSDictionary]()
        let viewPortStruct = ViewPortsConstructor()
        
        if viewPortPhone.intValue == 1 { viewPort.append(viewPortStruct.constructViewPorts("phone", vpWidth: 320, vpPortHeight: 480)) }
        if viewPortTabletV.intValue == 1 { viewPort.append(viewPortStruct.constructViewPorts("tablet_v", vpWidth: 568, vpPortHeight: 1024)) }
        if viewPortTabletF.intValue == 1 { viewPort.append(viewPortStruct.constructViewPorts("tablet_f", vpWidth: 1920, vpPortHeight: 1080)) }
        if viewPortTabletH.intValue == 1 { viewPort.append(viewPortStruct.constructViewPorts("tablet_h", vpWidth: 1024, vpPortHeight: 768)) }

        let scenarioStruct = ScenariosConstructor()

        let arrayOfScenarios = arrayOfLinks.map {
            scenarioStruct.constructScenario(trimDestinationPart("\\/\\w+\\/.+", text: $0),
                                            scUrl: $0,
                                            scHideSelectors: hideSelectorsTextField.stringValue,
                                            scRemoveSelectors: removeSelectorsTextField.stringValue,
                                            scSelectors: selectorsTextField.stringValue,
                                            scReadyEvent: readyEventTextField.stringValue,
                                            scDelay: Int(delayTextField.intValue),
                                            scMisMatchThreshold: misMatchThresholdTextField.doubleValue,
                                            scOnBeforeScript: onBeforeScriptTextField.stringValue,
                                            scOnReadyScript: onReadyScriptTextField.stringValue)
        }

        let pathsStruct = PathsConstructor()
        let paths = pathsStruct.constructPaths(bitmapsTestTextField.stringValue,
                                               pcBitmapsTest: bitmapsTestTextField.stringValue,
                                               pcCompareData: compareDataTextField.stringValue,
                                               pcCasperScripts: casperScriptsTextField.stringValue)
        
        if debugComboBox.stringValue == "false" {
            debugStatus = false
        } else { debugStatus = true }
        
        let completeDictionary = DictionaryConstructor()
        return completeDictionary.construct(viewPort, dcScenarios: arrayOfScenarios, dcPaths: paths, dcEngine: engineTextField.stringValue, dcReport: [reportTextField.stringValue], dcCasperFlags: [casperFlagsTextField.stringValue], dcDebug: debugStatus, dcPort: Int(portTextField.intValue))
    }
    
    func trimDestinationPart(regex: String!, text: String!) -> String {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matchesInString(text, options: [], range: NSMakeRange(0, nsString.length))
            let firstLoc = results.map { nsString.substringWithRange($0.range) }
            var firstElement: String!
            firstLoc.count > 0 ? (firstElement = firstLoc.first) : (firstElement = "/")
            return firstElement
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
    
    func dialogOKCancel(question: String, text: String, cancelButton: Bool) -> Bool {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = question
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.WarningAlertStyle
        myPopup.addButtonWithTitle("OK")
        if cancelButton {
            myPopup.addButtonWithTitle("Cancel")
        }
        let res = myPopup.runModal()
        if res == NSAlertFirstButtonReturn {
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var representedObject: AnyObject? {
        didSet {
        }
    }
}