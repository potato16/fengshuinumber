import 'package:dartz/dartz.dart';
import 'package:fengshuinumber/src/core/error/failures.dart';
import 'package:fengshuinumber/src/features/home/data/datasources/taboo_number_local_data_source.dart';
import 'package:fengshuinumber/src/features/home/domain/repositories/taboo_numbers_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabooNumbersRepositoryProvider = Provider<TabooNumbersRepository>((ref) {
  final localDataSource = ref.watch(tabooNumbersLocalDataSourceProvider);
  return TabooNumbersRepositoryImpl(localDataSource: localDataSource);
});

class TabooNumbersRepositoryImpl extends TabooNumbersRepository {
  TabooNumbersRepositoryImpl({required this.localDataSource});
  final TabooNumberLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<String>>> getNumbers() async {
    try {
      final result = await localDataSource.getNumbers();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
