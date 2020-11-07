struct InMemoryPirateDataSource: PirateDataSource {
    func nouns() -> [String] {
        ["Barnacles", "Crab-Legs", "Jetsam", "Mutiny"]
    }

    func adjectives() -> [String] {
        ["Blimey", "Toothless", "Crusty", "Cursed"]
    }
}
