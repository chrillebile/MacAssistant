/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: google/assistant/embedded/v1alpha1/embedded_assistant.proto
 *
 */

/*
 * Copyright 2017, gRPC Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import Foundation
import Dispatch
import gRPC
import SwiftProtobuf

/// Type for errors thrown from generated client code.
internal enum Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantClientError : Error {
  case endOfStream
  case invalidMessageReceived
  case error(c: CallResult)
}

/// Converse (Bidirectional Streaming)
internal class Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantConverseCall {
  private var call : Call

  /// Create a call.
  fileprivate init(_ channel: Channel) {
    self.call = channel.makeCall("/google.assistant.embedded.v1alpha1.EmbeddedAssistant/Converse")
  }

  /// Call this to start a call. Nonblocking.
  fileprivate func start(metadata:Metadata, completion:@escaping (CallResult)->())
    throws -> Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantConverseCall {
      try self.call.start(.bidiStreaming, metadata:metadata, completion:completion)
      return self
  }

  /// Call this to wait for a result. Blocking.
  internal func receive() throws -> Google_Assistant_Embedded_V1alpha1_ConverseResponse {
    var returnError : Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantClientError?
    var returnMessage : Google_Assistant_Embedded_V1alpha1_ConverseResponse!
    let sem = DispatchSemaphore(value: 0)
    do {
      try receive() {response, error in
        returnMessage = response
        returnError = error
        sem.signal()
      }
      _ = sem.wait(timeout: DispatchTime.distantFuture)
    }
    if let returnError = returnError {
      throw returnError
    }
    return returnMessage
  }

  /// Call this to wait for a result. Nonblocking.
  internal func receive(completion:@escaping (Google_Assistant_Embedded_V1alpha1_ConverseResponse?, Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantClientError?)->()) throws {
    do {
      try call.receiveMessage() {(data) in
        if let data = data {
          if let returnMessage = try? Google_Assistant_Embedded_V1alpha1_ConverseResponse(serializedData:data) {
            completion(returnMessage, nil)
          } else {
            completion(nil, Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantClientError.invalidMessageReceived)
          }
        } else {
          completion(nil, Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantClientError.endOfStream)
        }
      }
    }
  }

  /// Call this to send each message in the request stream.
  internal func send(_ message:Google_Assistant_Embedded_V1alpha1_ConverseRequest, errorHandler:@escaping (Error)->()) throws {
    let messageData = try message.serializedData()
    try call.sendMessage(data:messageData, errorHandler:errorHandler)
  }

  /// Call this to close the sending connection. Blocking.
  internal func closeSend() throws {
    let sem = DispatchSemaphore(value: 0)
    try closeSend() {
      sem.signal()
    }
    _ = sem.wait(timeout: DispatchTime.distantFuture)
  }

  /// Call this to close the sending connection. Nonblocking.
  internal func closeSend(completion:@escaping ()->()) throws {
    try call.close() {
      completion()
    }
  }

  /// Cancel the call.
  internal func cancel() {
    call.cancel()
  }
}

/// Call methods of this class to make API calls.
internal class Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantService {
  private var channel: Channel

  /// This metadata will be sent with all requests.
  internal var metadata : Metadata

  /// This property allows the service host name to be overridden.
  /// For example, it can be used to make calls to "localhost:8080"
  /// appear to be to "example.com".
  internal var host : String {
    get {
      return self.channel.host
    }
    set {
      self.channel.host = newValue
    }
  }

  /// Create a client that makes insecure connections.
  internal init(address: String) {
    gRPC.initialize()
    channel = Channel(address:address)
    metadata = Metadata()
  }

  /// Create a client that makes secure connections.
  internal init(address: String, certificates: String?, host: String?) {
    gRPC.initialize()
    channel = Channel(address:address, certificates:certificates, host:host)
    metadata = Metadata()
  }

  /// Asynchronous. Bidirectional-streaming.
  /// Use methods on the returned object to stream messages,
  /// to wait for replies, and to close the connection.
  internal func converse(completion: @escaping (CallResult)->())
    throws
    -> Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantConverseCall {
      return try Google_Assistant_Embedded_V1Alpha1_EmbeddedAssistantConverseCall(channel).start(metadata:metadata, completion:completion)
  }
}
