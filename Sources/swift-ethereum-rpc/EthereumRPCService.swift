import BigInt
import Foundation
import SwiftJSONRPC

public class EthereumRPCService: RPCService {
  /// Returns the chain ID of the current network.
  public func getChainId() async throws -> BigUInt {
    try hexStringToBigUInt(await invoke("eth_chainId"))
  }

  /// Returns the balance of the account for a given address.
  public func getBalance(_ address: String, blockTag: BlockTag = .latest) async throws -> BigUInt {
    try hexStringToBigUInt(await invoke("eth_getBalance", params: [address, blockTag.description]))
  }

  /// Returns the number of the most recent block.
  public func getBlockNumber() async throws -> BigUInt {
    try hexStringToBigUInt(await invoke("eth_blockNumber"))
  }

  /// Returns current price per gas in wei.
  public func getGasPrice() async throws -> BigUInt {
    try hexStringToBigUInt(await invoke("eth_gasPrice"))
  }

  /// Returns an object with data about the sync status or false.
  public func getSyncingStatus() async throws -> Any {
    try await invoke("eth_syncing")
  }
}
