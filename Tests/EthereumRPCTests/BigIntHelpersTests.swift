import BigInt
@testable import EthereumRPC
import XCTest

final class BigIntHelpersTests: XCTestCase {
  func testFormatUnits() {
    XCTAssertEqual(formatUnits(0, decimals: 0), "0")
    XCTAssertEqual(formatUnits(0, decimals: 18), "0")
    XCTAssertEqual(formatUnits(1, decimals: 18), "0.000000000000000001")
    XCTAssertEqual(formatUnits(420_000_000_000_000_000, decimals: 18), "0.42")
    XCTAssertEqual(formatUnits(4_200_000_000_000_000_000, decimals: 18), "4.2")
    XCTAssertEqual(formatUnits(2_000_000_000_000_000_000, decimals: 18), "2")
  }

  func testFormatEther() {
    XCTAssertEqual(formatEther(0), "0")
    XCTAssertEqual(formatEther(1), "0.000000000000000001")
    XCTAssertEqual(formatEther(420_000_000_000_000_000), "0.42")
    XCTAssertEqual(formatEther(4_200_000_000_000_000_000), "4.2")
    XCTAssertEqual(formatEther(2_000_000_000_000_000_000), "2")
  }

  func testParseUnits() {
    XCTAssertEqual(parseUnits("0", decimals: 18), 0)
    XCTAssertEqual(parseUnits("0.000000000000000001", decimals: 18), 1)
    XCTAssertEqual(parseUnits("0.42", decimals: 18), 420_000_000_000_000_000)
    XCTAssertEqual(parseUnits("4.2", decimals: 18), 4_200_000_000_000_000_000)
    XCTAssertEqual(parseUnits("2", decimals: 18), 2_000_000_000_000_000_000)
  }

  func testParseEther() {
    XCTAssertEqual(parseEther("0"), 0)
    XCTAssertEqual(parseEther("0.000000000000000001"), 1)
    XCTAssertEqual(parseEther("0.42"), 420_000_000_000_000_000)
    XCTAssertEqual(parseEther("4.2"), 4_200_000_000_000_000_000)
    XCTAssertEqual(parseEther("2"), 2_000_000_000_000_000_000)
  }
}
