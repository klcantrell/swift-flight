import PirateDataSource

func main() {
    let pirateDataSource: PirateDataSource = InMemoryPirateDataSource();
    let nouns = pirateDataSource.nouns()
    let adjectives = pirateDataSource.adjectives()
    
    guard let firstName = CommandLine.arguments.dropFirst().first else {
        print("Please provide at least yer first name, matey")
        return
    }
    
    if let lastName = CommandLine.arguments.dropFirst(2).first,
       let adjective = adjectiveOfName(name: lastName, availableAdjectives: adjectives) {
        print("Yer pirate name be \(firstName) \(adjective) \(lastName)")
    } else if let noun = nounOfName(name: firstName, availableNouns: nouns) {
        print("Yer pirate name be \(noun) \(firstName)")
    } else {
        noPirateNameFound()
    }
}

func noPirateNameFound() {
    print("Me thinks yer name already be good enough to be what yer pirate name would be")
}

func doesWordStartWithLetter(word: String, letter: String) -> Bool {
    if letter == "K" || letter == "C" {
        return word.starts(with: "K") || word.starts(with: "C")
    } else {
        return word.starts(with: letter) 
    }
}

func adjectiveOfName(name: String, availableAdjectives: [String]) -> String? {
    let firstLetterOfName = name.prefix(1)
    return availableAdjectives.first(where: {
        doesWordStartWithLetter(word: $0, letter: String(firstLetterOfName))
    })
}

func nounOfName(name: String, availableNouns: [String]) -> String? {
    let firstLetterOfName = name.prefix(1)
    return availableNouns.first(where: {
        doesWordStartWithLetter(word: $0, letter: String(firstLetterOfName))
    })
}

main()
