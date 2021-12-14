import Foundation
import L10n_swift

// MARK: - Strings
// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// home.cat.all.text
  internal static let all = L10n.tr("Localizable", "All")
  /// home.cat.pizza.text
  internal static let pizza = L10n.tr("Localizable", "Pizza")
  /// home.cat.burgers.text
  internal static let burgers = L10n.tr("Localizable", "Burgers")
  /// home.cat.title
  internal static let categories = L10n.tr("Localizable", "Categories")
  /// home.cat.coffee.text
  internal static let coffee = L10n.tr("Localizable", "Coffee")
  /// home.cat.chinese.text
  internal static let chinese = L10n.tr("Localizable", "Chinese")
  /// detail.nav.title
  internal static let favorites = L10n.tr("Localizable", "Favorites")
  /// permission.desc.text
  internal static let findNewCoolSpotsToEat = L10n.tr("Localizable", "Find new cool spots to eat")
  /// permission.title.text
  internal static let splfood = L10n.tr("Localizable", "Food Spotlight")
  /// permission.button.title
  internal static let getStarted = L10n.tr("Localizable", "Get Started")
  /// home.cat.sushi.text
  internal static let sushi = L10n.tr("Localizable", "Sushi")
  /// home.cat.british.text
  internal static let british = L10n.tr("Localizable", "British")
  /// home.cat.italian.text
  internal static let italian = L10n.tr("Localizable", "Italian")
  /// home.placeholder.text
  internal static let searchFood = L10n.tr("Localizable", "Search food...")
}

// MARK: - Implementation Details
extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
