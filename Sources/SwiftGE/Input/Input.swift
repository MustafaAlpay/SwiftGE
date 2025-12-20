import Foundation

public enum InputEvent: Sendable {
    case keyDown(code: String)
    case keyUp(code: String)
    case buttonDown(name: String)
    case buttonUp(name: String)
}

public final class InputState {
    private(set) var pressedKeys: Set<String>
    private(set) var pressedButtons: Set<String>

    public init() {
        self.pressedKeys = []
        self.pressedButtons = []
    }

    public func apply(event: InputEvent) {
        switch event {
        case let .keyDown(code):
            pressedKeys.insert(code)
        case let .keyUp(code):
            pressedKeys.remove(code)
        case let .buttonDown(name):
            pressedButtons.insert(name)
        case let .buttonUp(name):
            pressedButtons.remove(name)
        }
    }

    public func isKeyPressed(_ code: String) -> Bool {
        pressedKeys.contains(code)
    }

    public func isButtonPressed(_ name: String) -> Bool {
        pressedButtons.contains(name)
    }
}
