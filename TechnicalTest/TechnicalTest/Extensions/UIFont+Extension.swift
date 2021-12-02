import  UIKit

extension UIFont {
  public static func registerCustomFonts() {
    [
      R.file.openSansBoldTtf,
      R.file.openSansRegularTtf,
      R.file.openSansSemiBoldTtf,
      R.file.robotoLightTtf,
      R.file.robotoRegularTtf,
      R.file.robotoBoldTtf,
      R.file.robotoMediumTtf
    ]
    .compactMap { $0.url() }
    .forEach { CTFontManagerRegisterFontsForURL($0 as CFURL, .process, nil) }
  }
}
