import Foundation

let localizableFileExtension = "strings"

public func l10n(_ key: String) -> String {
    guard let filesURL = Bundle.main.urls(
        forResourcesWithExtension: localizableFileExtension,
        subdirectory: nil
    ) else { return key }
    let tablesName = filesURL.map { $0.deletingPathExtension().lastPathComponent }

    for tableName in tablesName {
        let result = Bundle.main.localizedString(forKey: key, value: nil, table: tableName)
        if result != key {
            return result
        }
    }

    return key
}

public func l10n(_ key: String, with arguments: CVarArg...) -> String {
    let localizedString = l10n(key)
    return String.localizedStringWithFormat(localizedString, arguments)
}
