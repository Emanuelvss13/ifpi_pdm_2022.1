import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exercicio_11/core/errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Params extends Equatable {
  final String name;

  const Params({required this.name});

  @override
  List<Object> get props => [name];
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
