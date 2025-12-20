import Foundation

public struct TimeState: Sendable {
    public private(set) var totalTime: TimeInterval
    public private(set) var deltaTime: TimeInterval
    public private(set) var frameCount: UInt64

    public init() {
        self.totalTime = 0
        self.deltaTime = 0
        self.frameCount = 0
    }

    mutating func step(deltaTime: TimeInterval) {
        self.deltaTime = deltaTime
        self.totalTime += deltaTime
        self.frameCount &+= 1
    }
}
