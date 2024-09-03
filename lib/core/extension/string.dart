extension StringExtension on String {
  String get convert {
    Map<String, String> convertItems = {'ı': 'i', 'ğ': 'g', 'ü': 'u', 'ş': 's', 'ö': 'o', 'ç': 'c'};
    String converted = toLowerCase().replaceAllMapped(RegExp('[ığüşöç]'), (match) => convertItems[match.group(0)]!).toLowerCase();
    return converted;
  }
}
