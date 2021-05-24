import 'package:dartz/dartz.dart';
import 'package:fengshuinumber/src/core/error/failures.dart';
import 'package:fengshuinumber/src/core/usecases/usecase.dart';
import 'package:fengshuinumber/src/features/home/data/repositories/taboo_numbers_repository_impl.dart';
import 'package:fengshuinumber/src/features/home/domain/repositories/taboo_numbers_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getTabooNumbersUseCaseProvider = Provider<GetTabooNumbersUseCase>((ref) {
  final repository = ref.watch(tabooNumbersRepositoryProvider);
  return GetTabooNumbersUseCase(repository);
});

class GetTabooNumbersUseCase implements UseCase<List<String>, NoParams> {
  GetTabooNumbersUseCase(this.repository);
  final TabooNumbersRepository repository;
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) {
    return repository.getNumbers();
  }
}
