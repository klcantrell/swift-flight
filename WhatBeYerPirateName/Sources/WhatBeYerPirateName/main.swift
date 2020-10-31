func run() {
  let db = DataAccess();
  print(db.getNouns())
  print(db.getAdjectives())

  guard CommandLine.arguments.count > 1 else {
    print("Please provide at least yer first name, matey")
    return
  }

  print("Yer pirate name be \(CommandLine.arguments[1])")
}

run()
