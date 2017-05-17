//
//  ViewController.swift
//  Sitemap to Scenario
//
//  Created by Enzo Sterro on 28.06.16.
//  Copyright © 2016 Enzo Sterro. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {


	// MARK: - Outlets

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
	@IBOutlet weak var portTextField: NSTextField!

	@IBOutlet weak var debugComboBox: NSComboBox!

	@IBOutlet weak var viewPortPhone: NSButton!
	@IBOutlet weak var viewPortTabletF: NSButton!
	@IBOutlet weak var viewPortTabletV: NSButton!
	@IBOutlet weak var viewPortTabletH: NSButton!


	// MARK: - Actions

	@IBAction func makeScenarioButtonPressed(_ sender: NSButton) {

		var contentOfUrl: String!

		if let url = URL(string: urlTextField.stringValue) {

			do {
				contentOfUrl = try NSString(contentsOf: url, usedEncoding: nil) as String
			} catch let error as NSError {
				print("Couldn't create URL: \(error.localizedDescription)") }
		}

		if contentOfUrl.contains("?xml") {
			let downloadsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .userDomainMask, true).first!
			let downloadsDirectoryPath = URL(string: downloadsDirectoryPathString)!
			let jsonFilePath = downloadsDirectoryPath.appendingPathComponent("backstop.json")
			let fileManager = FileManager.default
			var isDirectory: ObjCBool = false

			if !fileManager.fileExists(atPath: jsonFilePath.absoluteString, isDirectory: &isDirectory) {
				let created = fileManager.createFile(atPath: jsonFilePath.absoluteString, contents: nil, attributes: nil)
				if created { print("File created") }
				else { print("Couldn't create file for some reason") }
			} else {
				Alert.showDialog("Attention!", text: "Previous file will be overwritten!", cancelButton: true)
				let created = fileManager.createFile(atPath: jsonFilePath.absoluteString, contents: nil, attributes: nil)
				if created { print("File created") }
				else { print("Couldn't create file for some reason") }

			}

			var jsonData: Data!

			do {
				let xmlToUrl = xmlToArray(contentOfUrl)
				let dict = makeScenario(xmlToUrl)
				jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
			} catch let error as NSError {
				print("Dictionary to JSON conversion failed: \(error.localizedDescription)")
			}

			do {
				if let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as String? {

					// NSJSONSerialization serialization of a string containing forward slashes / is escaped incorrectly that's why you might feel nauseous below.

					let sReplace = "\""

					let sString1 = jsonString.replacingOccurrences(of: "\\/", with: "/", options: .caseInsensitive, range:nil)
					let sString2 = sString1.replacingOccurrences(of: "\"\\\"", with: sReplace, options: .literal, range: nil)
					let sString3 = sString2.replacingOccurrences(of: "\\\"\"", with: sReplace, options: .literal, range: nil)
					let sString4 = sString3.replacingOccurrences(of: "\\\"", with: sReplace, options: .literal, range: nil)

					let file = try FileHandle(forWritingTo: jsonFilePath)

					let dataToWrite = sString4.data(using: .utf8)!

					file.write(dataToWrite)

					Alert.showDialog("Success!", text: "File \"backstop.json\" successfully stored \nat ~\\Download location.", cancelButton: false)

					print("JSON data was written to the file successfully!")
				}
			} catch let error as NSError {
				print("Couldn't write to file: \(error.localizedDescription)")
			}
		} else {
			Alert.showDialog("Error", text: "Couldn't find XML data.", cancelButton: false)
		}
	}


	// MARK: - Convert XML to an Array

	func xmlToArray(_ inXml: String) -> [String] {
		let xml = SWXMLHash.parse(inXml)
		var arrayOfLocs = [String]()
		for elem in xml["urlset"]["url"] {
			let currentUrl = elem["loc"].element!.text!
			let invalidLinkRegex = try! NSRegularExpression(pattern: "(.pdf|.txt|.xml)", options: [])
			let nsString = currentUrl as NSString
			let arrayOfMatches = invalidLinkRegex.matches(in: currentUrl, options: [], range: NSMakeRange(0, nsString.length))
			let result = arrayOfMatches.map { nsString.substring(with: $0.range) }
			if result.count == 0 { arrayOfLocs.append(currentUrl) }
		}
		return arrayOfLocs
	}


	// MARK: - Make Scenario

	func makeScenario(_ arrayOfLinks: [String]) -> [String: AnyObject] {

		var viewPorts: [[String: AnyObject]] = []

		var debugStatus: Bool!

		if viewPortPhone.state == NSOnState { viewPorts.append(ViewPortsConstructor.construct("phone", vpWidth: 320, vpPortHeight: 480)) }
		if viewPortTabletV.state == NSOnState { viewPorts.append(ViewPortsConstructor.construct("tablet_v", vpWidth: 568, vpPortHeight: 1024)) }
		if viewPortTabletF.state == NSOnState { viewPorts.append(ViewPortsConstructor.construct("tablet_f", vpWidth: 1920, vpPortHeight: 1080)) }
		if viewPortTabletH..state == NSOnState { viewPorts.append(ViewPortsConstructor.construct("tablet_h", vpWidth: 1024, vpPortHeight: 768)) }

		let arrayOfScenarios = arrayOfLinks.map {
			ScenariosConstructor.construct(trimDestinationPart("\\/\\w+\\/.+", text: $0),
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

		let paths = PathsConstructor.construct(bitmapsTestTextField.stringValue,
		                                       pcBitmapsTest: bitmapsTestTextField.stringValue,
		                                       pcCompareData: compareDataTextField.stringValue,
		                                       pcCasperScripts: casperScriptsTextField.stringValue)

		if debugComboBox.stringValue == "false" {
			debugStatus = false
		} else { debugStatus = true }

		return DictionaryConstructor.construct(viewPorts, dcScenarios: arrayOfScenarios as [[String : AnyObject]], dcPaths: paths, dcEngine: engineTextField.stringValue, dcReport: [reportTextField.stringValue], dcCasperFlags: [casperFlagsTextField.stringValue], dcDebug: debugStatus, dcPort: Int(portTextField.intValue)) as [String : AnyObject]
	}


	// MARK: - Trim Destination Part

	func trimDestinationPart(_ regex: String!, text: String!) -> String {
		do {
			let regex = try NSRegularExpression(pattern: regex, options: [])
			let nsString = text as NSString
			let results = regex.matches(in: text, options: [], range: NSMakeRange(0, nsString.length))
			let firstLoc = results.map { nsString.substring(with: $0.range) }
			var firstElement: String!
			firstLoc.count > 0 ? (firstElement = firstLoc.first) : (firstElement = "/")
			return firstElement
		} catch let error as NSError {
			print("Invalid regex: \(error.localizedDescription)")
			return ""
		}
	}


	// MARK: - View Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
	}

}
