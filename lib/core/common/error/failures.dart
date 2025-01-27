import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure([List props = const []]) : super();
}

// general failures
class ServerFailure extends Failure {
  @override
  List<Object?> get props => ['ServerFailed'];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => ['Cache Failure'];
}

class DatabaseFailure extends Failure {
  @override
  List<Object?> get props => ['Database Error occurred.'];
}


class ConnectionFailure extends Failure {
  @override
  List<Object?> get props => ['Failed to connect to the network'];
}

class NoPermsissionFailure extends Failure {
  @override
  List<Object?> get props => ['Failed to Retrieve Permissions'];
}
