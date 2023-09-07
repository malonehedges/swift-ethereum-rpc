import BigInt

public enum BlockTag {
  case earliest
  case finalized
  case safe
  case latest
  case pending
  case block(BigUInt)
}

extension BlockTag: CustomStringConvertible {
  public var description: String {
    switch self {
    case .earliest:
      return "earliest"
    case .finalized:
      return "finalized"
    case .safe:
      return "safe"
    case .latest:
      return "latest"
    case .pending:
      return "pending"
    case let .block(bigInt):
      return "0x" + String(bigInt, radix: 16)
    }
  }
}

extension BlockTag: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode(String.self)

    if value.hasPrefix("0x"), let bigInt = BigUInt(value.dropFirst(2), radix: 16) {
      self = .block(bigInt)
    } else {
      switch value {
      case "earliest": self = .earliest
      case "finalized": self = .finalized
      case "safe": self = .safe
      case "latest": self = .latest
      case "pending": self = .pending
      default: throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid value")
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .earliest: try container.encode("earliest")
    case .finalized: try container.encode("finalized")
    case .safe: try container.encode("safe")
    case .latest: try container.encode("latest")
    case .pending: try container.encode("pending")
    case let .block(bigInt): try container.encode("0x" + String(bigInt, radix: 16))
    }
  }
}

extension BlockTag: Equatable {}
