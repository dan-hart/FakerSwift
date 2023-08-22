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
        query: .init(_quantity: "1", _characters: "250")
    )
)

switch response {
case .ok(let okResponse):
    switch okResponse.body {
    case .json(let objectContainer):
        let value = objectContainer.value as? [String: Any?]
        let data = value?["data"]
        print(data)
    }
case .undocumented(statusCode: let statusCode, _):
    print("🥺 undocumented response: \(statusCode)")
}

// Keep the console open
_ = readLine()
