// The Swift Programming Language
// https://docs.swift.org/swift-book

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

let client = Client(
    serverURL: try Servers.server1(),
    transport: URLSessionTransport()
)

let response = try await client.texts(
    .init(
        query: .init(_quantity: "2", _characters: "500")
    )
)

switch response {
case .ok(let okResponse):
    switch okResponse.body {
    case .json(let texts):
        for (index, text) in (texts.data ?? []).enumerated() {
            print("Text \(index + 1): \(text.content ?? "No Content")")
        }
    }
case .undocumented(statusCode: let statusCode, _):
    print("🥺 undocumented response: \(statusCode)")
}

// Keep the console open
_ = readLine()
