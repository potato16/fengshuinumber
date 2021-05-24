import 'package:dartz/dartz.dart';
import 'package:fengshuinumber/src/core/error/failures.dart';

abstract class TabooNumbersRepository {
  Future<Either<Failure, List<String>>> getNumbers();
}
