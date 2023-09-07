import BigInt
@testable import swift_ethereum_rpc
import SwiftJSONRPC
import XCTest

final class EthereumRPCServiceTests: XCTestCase {
    private var client: EthereumRPCService!

    private func getRPCURL() throws -> URL {
        guard let rpcUrlString = ProcessInfo.processInfo.environment["SWIFT_ETHEREUM_RPC_URL"],
              let rpcUrl = URL(string: rpcUrlString)
        else {
            if ProcessInfo.processInfo.environment["CI"] == "true" {
                XCTFail("Missing SWIFT_ETHEREUM_RPC_URL environment variable")
                throw URLError(.badURL)
            } else {
                return URL(string: "https://cloudflare-eth.com")!
            }
        }

        return rpcUrl
    }

    override func setUp() async throws {
        let rpcClient = try RPCClient(url: getRPCURL())
        client = EthereumRPCService(client: rpcClient)
    }

    func testGetChainId() async throws {
        let chainId = try await client.getChainId()
        XCTAssertEqual(chainId, BigUInt(1))
    }

    func testBalanceVitalik() async throws {
        let account = "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045"
        let balance = try await client.getBalance(account, blockTag: .block(18_075_306))
        XCTAssertEqual(balance, BigUInt("933814025650785388834"))
    }

    func testGetBlockNumber() async throws {
        let blockNumber = try await client.getBlockNumber()
        XCTAssertGreaterThan(blockNumber, 18_075_306)
    }

    func testGetGasPrice() async throws {
        let gasPrice = try await client.getGasPrice()
        XCTAssertGreaterThan(gasPrice, 0)
    }
}
