import BigInt
@testable import EthereumRPC
import XCTest

final class BlockTagTests: XCTestCase {
  func testBlockTagDescription() {
    XCTAssertEqual(BlockTag.earliest.description, "earliest")
    XCTAssertEqual(BlockTag.finalized.description, "finalized")
    XCTAssertEqual(BlockTag.safe.description, "safe")
    XCTAssertEqual(BlockTag.latest.description, "latest")
    XCTAssertEqual(BlockTag.pending.description, "pending")
    XCTAssertEqual(BlockTag.block(BigUInt(255)).description, "0xff")
  }

  func testBlockTagDecoding() throws {
    let decoder = JSONDecoder()
    let earliestData = "\"earliest\"".data(using: .utf8)!
    var tag = try decoder.decode(BlockTag.self, from: earliestData)
    XCTAssertEqual(tag, .earliest)

    let blockData = "\"0xff\"".data(using: .utf8)!
    tag = try decoder.decode(BlockTag.self, from: blockData)
    XCTAssertEqual(tag, .block(BigUInt(255)))
  }

  func testBlockTagEncoding() throws {
    let encoder = JSONEncoder()
    let earliest = BlockTag.earliest
    let data = try encoder.encode(earliest)
    XCTAssertEqual(String(data: data, encoding: .utf8), "\"earliest\"")

    let block = BlockTag.block(BigUInt(255))
    let blockData = try encoder.encode(block)
    XCTAssertEqual(String(data: blockData, encoding: .utf8), "\"0xff\"")
  }
}
