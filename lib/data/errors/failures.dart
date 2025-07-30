import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});
}

class GetJokeAPIFailure extends Failure {
  const GetJokeAPIFailure({required super.message});
}

class GetJokeFailure extends Failure {
  const GetJokeFailure({required super.message});
}
