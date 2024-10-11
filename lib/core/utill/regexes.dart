class RegExes {
  RegExes._();

  static final RegExp idNo =
      RegExp(r'[a-zA-Z0-9\u1780-\u178F\u1790-\u179F\u17A0-\u17AF\u17B0-\u17BF\u17C0-\u17CF\u17D0-\u17D3\u17DD\(\)]');
  // static final RegExp latinCharacters = RegExp(r'[a-zA-Z]');
  static final RegExp latinCharacters = RegExp(r'[a-zA-Z\s\(\)]');
  // static final RegExp khmerCharacters = RegExp(r'[\u1780-\u178F\u1790-\u179F\u17A0-\u17AF\u17B0-\u17BF\u17C0-\u17CF\u17D0-\u17D3\u17DD]');
  static final RegExp khmerCharacters =
      RegExp(r'[\u1780-\u178F\u1790-\u179F\u17A0-\u17AF\u17B0-\u17BF\u17C0-\u17CF\u17D0-\u17D3\u17DD\s\(\)]');
  static final RegExp nameCharacters =
      RegExp(r'[a-zA-Z\u1780-\u178F\u1790-\u179F\u17A0-\u17AF\u17B0-\u17BF\u17C0-\u17CF\u17D0-\u17D3\u17DD\s\(\)]');
  static final RegExp currency = RegExp(r'[0-9\.]');
  static final RegExp amount = RegExp(r'[0-9,]');
  static final RegExp amountKHR = RegExp(r'[0-9-]');
  static final RegExp decimal = RegExp(r'[0-9\.]');
  static final RegExp digit = RegExp(r'[0-9]');
  static final RegExp currencyKHR = RegExp(r'^\d+\.?\d{0,2}');
  static final RegExp currencyUSD = RegExp(r'^[,.0-9]+$');
}
