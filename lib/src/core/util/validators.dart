import 'allow_phones.dart';

String? phoneValidator(String? input) {
  if (input == null || input.isEmpty) {
    return 'Please enter valid phone number!';
  }
  if (input.length != 10) {
    return 'Please enter valid phone number!';
  }
  final allowsPhone = AllowPhoneFormat();
  final lead = input.substring(0, 3);
  if (allowsPhone.allows.contains(lead)) {
    return null;
  }
  return 'We only support phone number from these carriers: Viettel, Mobile phone, Vinaphone.';
}
