import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:appwrite_incidence_employe/data/network/failure.dart';
import 'package:appwrite_incidence_employe/data/request/request.dart';
import 'package:appwrite_incidence_employe/domain/model/incidence_model.dart';
import 'package:appwrite_incidence_employe/domain/model/name_model.dart';
import 'package:appwrite_incidence_employe/domain/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Session>> login(LoginRequest loginRequest);

  Future<Either<Failure, Token>> forgotPassword(String email);

  Future<Either<Failure, dynamic>> deleteSession(String sessionId);

  Future<Either<Failure, Incidences>> incidences(
      List<dynamic> queries, int limit, int offset);

  Future<Either<Failure, Incidence>> incidence(String incidenceId);

  Future<Either<Failure, Incidence>> incidenceCreate(Incidence incidence);

  Future<Either<Failure, UsersModel>> user(String userId);

  Future<Either<Failure, File>> createFile(Uint8List uint8list, String name);

  Future<Either<Failure, List<Name>>> prioritys(int limit, int offset);
}
