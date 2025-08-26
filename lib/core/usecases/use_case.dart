import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<F, S, P> {
  Future<Either<F, S>> call(P params);
}
