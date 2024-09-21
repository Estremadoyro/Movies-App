//
//  Logger.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

enum LogEvent {
    case network
    case mock
    case local
    case info
    case coreData
    case widget
    case coding

    var emoji: String {
        switch self {
            case .network: return "📡"
            case .mock: return "🧪"
            case .local: return "📱"
            case .info: return "🗞️"
            case .coreData: return "💾"
            case .widget: return "🧩"
            case .coding: return "🔧"
        }
    }
}

enum LogResult {
    case success
    case error
    case other

    var emoji: String {
        switch self {
            case .success: return " -> ✅"
            case .error: return " -> ❌"
            case .other: return ""
        }
    }
}

final class Logger {
    private init() {}
    static func log(_ event: LogEvent = .info,
                    _ result: LogResult = .other,
                    msg: String,
                    active: Bool = true,
                    function: String = #function,
                    file: String = #fileID,
                    line: Int = #line) {
        let emojiEventStr: String = Self.getLogEmoji(event)
        let emojiResultStr: String = Self.getLogEmoji(result)

        guard active else { return }
        let log = """
        Logger - [\(emojiEventStr)\(emojiResultStr)] @ \(makeNowDateStr()))
        | \(msg)
        | func: \(function)
        | file: \(file)
        | line: \(line)

        """
        print(log)
    }

    private static func makeNowDateStr() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter.string(from: now)
    }
}

// MARK: - Private implementations
private extension Logger {
    static func getLogEmoji(_ event: LogEvent) -> String {
        let emojiStr = "\(event.emoji)"
        return emojiStr
    }

    static func getLogEmoji(_ result: LogResult) -> String {
        let emojiStr = "\(result.emoji)"
        return emojiStr
    }
}
