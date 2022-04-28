import 'package:appwrite/models.dart';
import 'package:appwrite_incidence_employe/data/network/failure.dart';
import 'package:appwrite_incidence_employe/data/request/request.dart';
import 'package:appwrite_incidence_employe/domain/model/user_model.dart';
import 'package:appwrite_incidence_employe/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class LoginUseCase
    implements
        BaseUseCase<LoginUseCaseInput, Session>,
        LoginUseCaseAccount<String, UsersModel> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Session>> execute(LoginUseCaseInput input) =>
      _repository.login(LoginRequest(input.email, input.password));

  @override
  Future<Either<Failure, UsersModel>> user(String userId) =>
      _repository.user(userId);
}

class LoginUseCaseInput {
  String email, password;

  LoginUseCaseInput(this.email, this.password);
}

abstract class LoginUseCaseAccount<In, Out> {
  Future<Either<Failure, Out>> user(In input);
}
