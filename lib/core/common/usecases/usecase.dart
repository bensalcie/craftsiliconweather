import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

// base usecase from whcih all usecases will
// implement call method.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type?>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

// Pass this when the usecase expects no parameters
// e.g a call to get a list of shows
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Common params where input is an id of type [int].
class IdParams extends Equatable {
  final int id;

  const IdParams(this.id);

  @override
  List<Object?> get props => [id];
}

class PaginationParams extends Equatable {
  final int? currentPage;
  final String? payeeAccountName;
  final String? createStartTime;
  final String? createEndTime;

  const PaginationParams(
      {this.createStartTime,
      this.createEndTime,
      this.currentPage,
      this.payeeAccountName});

  @override
  List<Object?> get props => [currentPage, payeeAccountName];
}
