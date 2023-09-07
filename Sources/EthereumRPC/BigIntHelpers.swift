import BigInt
import Foundation

let trailingZerosRegex = try! NSRegularExpression(pattern: "(0+)$", options: .caseInsensitive)

public func formatUnits(_ value: BigUInt, decimals: Int) -> String {
  var display = String(value)

  let paddingCount = max(0, decimals - display.count)
  display = String(repeating: "0", count: paddingCount) + display

  let integer = String(display.prefix(display.count - decimals))
  var fraction = String(display.suffix(decimals))

  let fractionRange = NSRange(fraction.startIndex..., in: fraction)
  fraction = trailingZerosRegex.stringByReplacingMatches(in: fraction, options: [], range: fractionRange, withTemplate: "")

  return "\(integer.isEmpty ? "0" : integer)\(fraction.isEmpty ? "" : ".\(fraction)")"
}

public func formatEther(_ value: BigUInt) -> String {
  return formatUnits(value, decimals: 18)
}

public func formatGwei(_ value: BigUInt) -> String {
  return formatUnits(value, decimals: 9)
}

public func parseUnits(_ value: String, decimals: Int) -> BigInt {
  let components = value.components(separatedBy: ".")
  let integer = components[0]
  let fraction = components.count > 1 ? components[1] : ""

  let paddingCount = max(0, decimals - fraction.count)
  let fractionPadded = fraction + String(repeating: "0", count: paddingCount)

  return BigInt(integer + fractionPadded)!
}

public func parseEther(_ value: String) -> BigInt {
  return parseUnits(value, decimals: 18)
}

public func parseGwei(_ value: String) -> BigInt {
  return parseUnits(value, decimals: 9)
}

struct InvalidHexError: Error {}

func hexStringToBigInt(_ hex: String) throws -> BigInt {
  guard let bigInt = BigInt(hex.dropFirst(2), radix: 16) else {
    throw InvalidHexError()
  }

  return bigInt
}

func hexStringToBigUInt(_ hex: String) throws -> BigUInt {
  guard let bigInt = BigUInt(hex.dropFirst(2), radix: 16) else {
    throw InvalidHexError()
  }

  return bigInt
}
