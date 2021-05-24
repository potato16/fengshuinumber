import 'package:fengshuinumber/src/core/usecases/usecase.dart';
import 'package:fengshuinumber/src/core/util/allow_phones.dart';
import 'package:fengshuinumber/src/core/util/asset_path.dart';
import 'package:fengshuinumber/src/core/util/validators.dart';
import 'package:fengshuinumber/src/features/home/domain/usecases/get_taboo_numbers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneNumberInputProvider = StateProvider<String>((ref) => '');

final phoneValidationProvider = Provider<bool>((ref) {
  final phone = ref.watch(phoneNumberInputProvider).state;
  return phoneValidator(phone) == null;
});

final carrierLogoProvider = Provider<String>((ref) {
  final phoneNumberInput = ref.watch(phoneNumberInputProvider).state;
  final allowFormat = AllowPhoneFormat();

  for (final f in allowFormat.viettel) {
    if (phoneNumberInput.startsWith(f)) {
      return AssetPath.imgViettel;
    }
  }
  for (final f in allowFormat.mobilePhone) {
    if (phoneNumberInput.startsWith(f)) {
      return AssetPath.imgMobiFone;
    }
  }
  for (final f in allowFormat.vinaPhone) {
    if (phoneNumberInput.startsWith(f)) {
      return AssetPath.imgVinaPhone;
    }
  }
  return '';
});

//------------------------------

final verifyFengShuiNumberProvider =
    StateNotifierProvider<VerifyFengShuiNumberStateNotifier, bool?>((ref) {
  final getTabooNumbersUsecase = ref.watch(getTabooNumbersUseCaseProvider);
  return VerifyFengShuiNumberStateNotifier(null,
      getTabooNumbersUseCase: getTabooNumbersUsecase, reader: ref.read);
});

class VerifyFengShuiNumberStateNotifier extends StateNotifier<bool?> {
  VerifyFengShuiNumberStateNotifier(bool? state,
      {required this.getTabooNumbersUseCase, required this.reader})
      : super(state);
  final GetTabooNumbersUseCase getTabooNumbersUseCase;
  List<String> _tabooNumbers = [];
  final List<String> _niceNumbers = ["19", "24", "26", "37", "34"];
  Reader reader;

  Future<void> check() async {
    if (_tabooNumbers.isEmpty) {
      final result = await getTabooNumbersUseCase.call(NoParams());
      _tabooNumbers = result.fold((l) => [], (r) => r);
    }

    final phone = reader(phoneNumberInputProvider).state;

    final isValid = phoneValidator(phone) == null;

    if (isValid) {
      bool isTaboo = false;
      for (final t in _tabooNumbers) {
        if (phone.endsWith(t)) {
          isTaboo = true;
          break;
        }
      }
      if (isTaboo) {
        state = false;
        return;
      }

      bool isNiceNumber = false;
      for (final t in _niceNumbers) {
        if (phone.endsWith(t)) {
          isNiceNumber = true;
          break;
        }
      }
      final List<int> numbers =
          phone.split('').map((e) => int.parse(e)).toList();
      final first = numbers
          .getRange(0, 5)
          .fold<int>(0, (previousValue, element) => previousValue + element);

      final last = numbers
          .getRange(5, 10)
          .fold<int>(0, (previousValue, element) => previousValue + element);
      final ratio = first / last;
      final isNiceRatio = ratio == 24 / 28 || ratio == 24 / 29;
      state = isNiceRatio && isNiceNumber;
    }
  }
}
