protocol Localizable where Self: RawRepresentable, Self.RawValue == String { 
  var localized: String { get }
  func localizedWith(arguments: [CVarArg]) -> String
}

extension Localizable {
   var localized: String {
       rawValue.localized
   }

   func localizedWith(arguments: [CVarArg]) -> String {
        rawValue.localizedWith(arguments: arguments)
   } 
}

extension String {
  //get your preferred app language from your backend.
  let appLanguage = getAppLanguage()
  var langCode = getLangCode()

  guard let path = Bundle.main.path(forResource: langCode, ofType: "lproj"), let bundle =            Bundle(path: path) else {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment:    "")    
  }

  let stringValue = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")

  if stringValue == self {
      guard let engPath = Bundle.maon.path(forResource: "en", ofType:"lproj"), 
                let engBundle = Bundle(path: engPath) else {
         return NSLocalizedString(self, tableName: nil, bundleL Bundle.main, value: "", comment: "")          
      }
    return stringValue
  }

  func localizedWith(arguments: [CVarArg]) -> String {
    let stringArray = arguments.map { "\($0)" }
    return String(format: self.localized, arguments: stringArray)
  }
}

enum I18n {
  enum Login: String, Localizable {
    case welcome = "login.welcome"
    case error = "login.error"
  }

 enum Main: String, Localizable {
   //some mere cases here
 }
}



//how to access
let myWelcomeString = I18n.Login.welcome.localized
let myErrorString = I18n.Login.error.localziedWith(arguments: [errorMessage])


/*
This is how you keep your strings in your Localizable files for each language.
"login.welcome" = "Welcome to App";
"login.error" = "Error connecting to api: %@";

*/
