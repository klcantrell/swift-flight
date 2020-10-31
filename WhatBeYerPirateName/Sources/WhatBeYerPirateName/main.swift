func run() {
  let dataSource: DataSource = InMemoryDataSource();
  print(dataSource.getNouns())
  print(dataSource.getAdjectives())

  guard let firstName = CommandLine.arguments.dropFirst().first else {
    print("Please provide at least yer first name, matey")
    return
  }

  print("Yer pirate name be \(firstName)")

  if let lastName = CommandLine.arguments.dropFirst(2).first {
    print("Yer surname be \(lastName)")
  }
}

run()
