#!/usr/bin/swift
import Foundation

func color(_ num: Character) -> String? {
	switch num {
		// case "0": "black" // black by default, so don't actually add a tag for it
		case "1": "green"
		case "2": "red"
		case "3": "brown"
		case "4": "blue"
		case "5": "pink"
		case "6": "hot-pink"
		case "7": "faded-blue"
		case "8": "orange"
		case "9": "white"
		default: nil
	}
}

func getCode(
	_ string: some StringProtocol,
	previous: inout String?
) -> (skip: Int, output: String) {
	var result = ""
	
	func openResult() {
		result += "<dialogue-color-code>"
	}
	
	func closeResult() {
		result += "</dialogue-color-code>"
	}
	
	guard let first = string.first else {
		openResult()
		result += "$"
		closeResult()
		return (0, result)
	}
	
	switch first {
		case "a":
			if let nextCharacter = string.dropFirst().first,
			   nextCharacter == "0" || nextCharacter == "1"
			{
				openResult()
				result += "$a\(nextCharacter)"
				closeResult()
				return (2, result)
			} else {
				openResult()
				result += "$a"
				closeResult()
				return (1, result)
			}
		case "c":
			if let prev = previous {
				result += prev
				previous = nil
			}
			
			if let nextCharacter = string.dropFirst().first {
				if let color = color(nextCharacter) {
					openResult()
					result += "$c\(nextCharacter)"
					closeResult()
					result += "<dialogue-\(color)>"
					previous = "</dialogue-\(color)>"
					return (2, result)
				} else {
					openResult()
					result += "$c\(nextCharacter)"
					closeResult()
					return (2, result)
				}
			} else {
				openResult()
				result += "$c"
				closeResult()
				return (1, result)
			}
		case "f":
			openResult()
			result += "$f"
			closeResult()
			return (1, result)
		case "q":
			let argument = string.dropFirst().prefix(while: \.isNumber)
			
			openResult()
			result += "$q\(argument)"
			closeResult()
			return (1 + argument.count, result)
		case "t":
			let argument = string.dropFirst().prefix(while: \.isNumber)
			
			openResult()
			result += "$t\(argument)"
			closeResult()
			return (1 + argument.count, result)
		case "w":
			let argument = string.dropFirst().prefix(while: \.isNumber)
			
			openResult()
			result += "$w\(argument)"
			closeResult()
			return (1 + argument.count, result)
		default:
			return (0, "$")
	}
}

func process(_ input: String) -> String {
	let codeIndices = input.indices(of: "$").ranges
	
	guard !codeIndices.isEmpty else {
		return input
	}
	
	var output = ""
	var previousTag: String? = nil
	var parsedIndex = input.startIndex
	
	for index in codeIndices {
		guard parsedIndex != input.startIndex else {
			output += input[..<index.lowerBound]
			parsedIndex = index.upperBound
			continue
		}
		
		let (skip, string) = getCode(
			input[parsedIndex..<index.lowerBound],
			previous: &previousTag
		)
		
		output += string
		output += input[parsedIndex..<index.lowerBound].dropFirst(skip)
		
		parsedIndex = index.upperBound
	}
	
	let (skip, string) = getCode(input[parsedIndex...], previous: &previousTag)
	
	output += string
	output += input[parsedIndex...].dropFirst(skip)
	
	if let previousTag {
		output += previousTag
	}
	
	// print(output)
	// exit(0)
	
	return output
}

struct Line: Codable {
	var index: Int
	var string: String
}

let rawInput = try Data(contentsOf: URL(filePath: "inputDialogue.json")!)
let input = try JSONDecoder()
	.decode([Line].self, from: rawInput)
	.map { Line(index: $0.index, string: process($0.string)) }
	.sorted { $0.index < $1.index }

let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

try encoder.encode(input).write(to: URL(filePath: "dialogue.json"))

