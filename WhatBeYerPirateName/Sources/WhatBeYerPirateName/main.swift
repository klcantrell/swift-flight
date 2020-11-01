import PirateDataSource

private func run() {
    let pirateDataSource: PirateDataSource = InMemoryPirateDataSource();
    let nouns = pirateDataSource.nouns()
    let adjectives = pirateDataSource.adjectives()

    guard let firstName = CommandLine.arguments.dropFirst().first else {
        print("Please provide at least yer first name, matey")
        return
    }

    if let lastName = CommandLine.arguments.dropFirst(2).first {
        let firstLetterOfLastName = lastName.prefix(1)
        if let adjective = adjectives.first(where: { 
            doesWordStartWithLetter(word: $0, letter: String(firstLetterOfLastName)) 
        }) {
            print("Yer pirate name be \(firstName) \(adjective) \(lastName)")
            return
        } else {
            noPirateNameFound()
            return
        }
    }

    let firstLetterOfFirstName = firstName.prefix(1)
    if let noun = nouns.first(where: {
        doesWordStartWithLetter(word: $0, letter: String(firstLetterOfFirstName))
    }) {
        print("Yer pirate name be \(noun) \(firstName)")
        return
    } else {
        noPirateNameFound()
        return
    }
}

private func noPirateNameFound() {
    print("Yer pirate name be what yer name already be")
}

private func doesWordStartWithLetter(word: String, letter: String) -> Bool {
    if String(letter) == "K" || String(letter) == "C" {
        return word.starts(with: "K") || word.starts(with: "C")
    } else {
        return word.starts(with: letter) 
    }
}

run()
