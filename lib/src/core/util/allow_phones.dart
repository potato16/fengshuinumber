class AllowPhoneFormat {
  AllowPhoneFormat._();
  static final AllowPhoneFormat _instance = AllowPhoneFormat._();
  factory AllowPhoneFormat() => _instance;

  final List<String> viettel = ['086', '096', '097'];
  final List<String> mobilePhone = ['089', '090', '093'];
  final List<String> vinaPhone = ['088', '091', '094'];
  List<String> get allows => [...viettel, ...mobilePhone, ...vinaPhone];
}
