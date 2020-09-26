import Foundation

let fm = FileManager.default
let path = URL(fileURLWithPath: Bundle.main.resourcePath!)

let files = try! fm.contentsOfDirectory(at: path, 
                    includingPropertiesForKeys: [.nameKey, .creationDateKey, .contentModificationDateKey], 
                    options: .skipsHiddenFiles)

for file in files {
    let fileAttributes = try! file.resourceValues(forKeys: [.nameKey, .creationDateKey, .contentModificationDateKey])
    
    let formattedName = fileAttributes.name ?? "unknown name"
    
    var formattedDate: String
    if let fileDateAttribute = (fileAttributes.creationDate ?? fileAttributes.contentModificationDate) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        // formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formattedDate = formatter.string(from: fileDateAttribute)
    } else {
        formattedDate = "unknown date"
    }

    print("Found \(formattedName), created \(formattedDate)")
}
