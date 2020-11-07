struct PirateNameGenerator {
    let pirateDataSource: PirateDataSource
    
    func forFirstName(_ firstName: String) -> String {
        let nouns = pirateDataSource.nouns()
        if let noun = nounForName(name: firstName, availableNouns: nouns) {
            return "Yer pirate name be \(noun) \(firstName)"
        } else {
            return noPirateNameFound
        }
    }
    
    func forFullName(firstName: String, lastName: String) -> String {
        let adjectives = pirateDataSource.adjectives()
        if let adjective = adjectiveForName(name: lastName, availableAdjectives: adjectives) {
            return "Yer pirate name be \(firstName) \(adjective) \(lastName)"
        } else {
            return forFirstName(firstName)
        }
    }

    func doesWordStartWithLetter(word: String, letter: String) -> Bool {
        if letter == "K" || letter == "C" {
            return word.starts(with: "K") || word.starts(with: "C")
        } else {
            return word.starts(with: letter)
        }
    }

    private func adjectiveForName(name: String, availableAdjectives: [String]) -> String? {
        let firstLetterOfName = name.prefix(1)
        return availableAdjectives.first(where: {
            doesWordStartWithLetter(word: $0, letter: String(firstLetterOfName))
        })
    }

    private func nounForName(name: String, availableNouns: [String]) -> String? {
        let firstLetterOfName = name.prefix(1)
        return availableNouns.first(where: {
            doesWordStartWithLetter(word: $0, letter: String(firstLetterOfName))
        })
    }
}

private let noPirateNameFound = "Me thinks yer name already be good enough to be what yer pirate name would be"
