import Vapor

struct PirateNameGenerator {
    let pirateDataSource: PirateDataSource
    
    func forFirstName(_ firstName: String) throws -> String {
        let nouns = pirateDataSource.nouns()
        if let noun = nounForName(name: firstName, availableNouns: nouns) {
            return "\(noun) \(firstName)"
        } else {
            throw noPirateNameFound
        }
    }
    
    func forFullName(firstName: String, lastName: String) throws -> String {
        let adjectives = pirateDataSource.adjectives()
        if let adjective = adjectiveForName(name: lastName, availableAdjectives: adjectives) {
            return "\(firstName) \(adjective) \(lastName)"
        } else {
            return try forFirstName(firstName)
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

private let noPirateNameFound = Abort(.badRequest, reason: "Me thinks yer name already be good enough to be what yer pirate name would be")
