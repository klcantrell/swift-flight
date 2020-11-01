public struct InMemoryPirateDataSource: PirateDataSource {
    public func nouns() -> [String] {
        ["Barnacles", "Crab-Legs", "Jetsam", "Mutiny"]
    }

    public func adjectives() -> [String] {
        ["Blimey", "Toothless", "Crusty", "Cursed"]
    }

    public init () {}
}
