//
//  ViewController.swift
//  Sitemap to Scenario
//
//  Created by Enzo Sterro on 28.06.16.
//  Copyright © 2016 Enzo Sterro. All rights reserved.
//

import Cocoa


final class ViewController: NSViewController {


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
				fileManager.createFile(atPath: jsonFilePath.absoluteString, contents: nil, attributes: nil)
			} else {
				Alert.showDialog(withTitle: "Attention!", informativeText: "Previous file will be overwritten!", cancelButton: true)
				let created = fileManager.createFile(atPath: jsonFilePath.absoluteString, contents: nil, attributes: nil)
				if created { print("File created") }
				else { print("Couldn't create file for some reason") }
			}

			var jsonData: Data!

			do {
				let xmlToUrl = getLocations(from: contentOfUrl)
				let dict = makeScenario(for: xmlToUrl)
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

					Alert.showDialog(withTitle: "Success!", informativeText: "File \"backstop.json\" successfully stored \nat ~\\Download location.", cancelButton: false)

				}
			} catch let error as NSError {
				print("Couldn't write to file: \(error.localizedDescription)")
			}
		} else {
			Alert.showDialog(withTitle: "Error", informativeText: "Couldn't find XML data.", cancelButton: false)
		}
	}


	// MARK: - Convert XML to an Array

	/**
	Parses locations in XML string and adds them to array.
	
	- Parameter xml: An XML string.
	- Returns: An array of all locations except contain `.pdf`, `.txt` and other `.xml` files.
	*/
	private func getLocations(from xml: String) -> [String] {
		let xml = SWXMLHash.parse(xml)
		var locations: [String] = []

		for element in xml["urlset"]["url"] {
			let location = element["loc"].element!.text!
			let invalidLocation = try! NSRegularExpression(pattern: "(.pdf|.txt|.xml)", options: [])
			let nsString = location as NSString
			let arrayOfMatches = invalidLocation.matches(in: location, options: [], range: NSMakeRange(0, nsString.length))
			let result = arrayOfMatches.map { nsString.substring(with: $0.range) }
			if result.count == 0 { locations.append(location) }
		}

		return locations
	}


	// MARK: - Make Scenario

	private func makeScenario(for arrayOfLinks: [String]) -> [String: AnyObject] {

		var viewPorts: [[String: AnyObject]] = []

		if viewPortPhone.state == NSOnState { viewPorts.append(ViewPortsConstructor.construct("phone", vpWidth: 320, vpPortHeight: 480)) }
		if viewPortTabletV.state == NSOnState { viewPorts.append(ViewPortsConstructor.construct("tablet_v", vpWidth: 568, vpPortHeight: 1024)) }
		if viewPortTabletF.state == NSOnState { viewPorts.append(ViewPortsConstructor.construct("tablet_f", vpWidth: 1920, vpPortHeight: 1080)) }
		if viewPortTabletH.state == NSOnState { viewPorts.append(ViewPortsConstructor.construct("tablet_h", vpWidth: 1024, vpPortHeight: 768)) }

		let arrayOfScenarios = arrayOfLinks.map {
			ScenariosConstructor.construct(scLabel: truncateToDestinationPart(withPattern: "\\/\\w+\\/.+", in: $0) ?? "",
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

		let paths = PathsConstructor.construct(pcBitmapsReference: bitmapsTestTextField.stringValue,
		                                       pcBitmapsTest: bitmapsTestTextField.stringValue,
		                                       pcCompareData: compareDataTextField.stringValue,
		                                       pcCasperScripts: casperScriptsTextField.stringValue)

		let debugStatus = debugComboBox.stringValue == "true"

		return DictionaryConstructor.construct(dcViewPorts: viewPorts,
		                                       dcScenarios: arrayOfScenarios as [[String: AnyObject]],
		                                       dcPaths: paths,
		                                       dcEngine: engineTextField.stringValue,
		                                       dcReport: [reportTextField.stringValue],
		                                       dcCasperFlags: [casperFlagsTextField.stringValue],
		                                       dcDebug: debugStatus,
		                                       dcPort: Int(portTextField.intValue)) as [String: AnyObject]
	}


	// MARK: - Truncate Destination Part


	/**
	Truncates `text` with a given `pattern`.

	- Parameter pattern: A pattern for Regular Expression.
	- Parameter text: Provide text for truncating.
	- Returns: A new truncated string or `nil` if an incorrect pattern was given.
	*/
	private func truncateToDestinationPart(withPattern pattern: String, in text: String) -> String? {
		do {
			let regex = try NSRegularExpression(pattern: pattern, options: [])
			let nsString = text as NSString
			let results = regex.matches(in: text, options: [], range: NSMakeRange(0, nsString.length))
			let firstLoc = results.map { nsString.substring(with: $0.range) }
			return firstLoc.count > 0 ? firstLoc.first! : "/"
		} catch let error as NSError {
			print("Invalid regex: \(error.localizedDescription)")
			return nil
		}
	}


	// MARK: - View Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
	}

}
