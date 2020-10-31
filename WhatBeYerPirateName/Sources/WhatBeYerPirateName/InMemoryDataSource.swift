struct InMemoryDataSource: DataSource {
  func getNouns() -> [String] {
    ["Eye-Patch", "Crab"]
  }

  func getAdjectives() -> [String] {
    ["Smelly", "Salty"]
  }
}
