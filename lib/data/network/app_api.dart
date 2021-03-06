import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_incidence_employe/app/app_preferences.dart';
import 'package:appwrite_incidence_employe/app/constants.dart';
import 'package:appwrite_incidence_employe/data/request/request.dart';
import 'package:appwrite_incidence_employe/data/responses/incidence_response.dart';
import 'package:appwrite_incidence_employe/domain/model/incidence_model.dart';
import 'package:http_parser/http_parser.dart';

class AppServiceClient {
  final Account _account;
  final Database _database;
  final Storage _storage;

  AppServiceClient(Client _client, AppPreferences _appPreferences)
      : _account = Account(_client),
        _database = Database(_client),
        _storage = Storage(_client);

  Future<Session> login(LoginRequest loginRequest) => _account.createSession(
      email: loginRequest.email, password: loginRequest.password);

  Future<Token> forgotPassword(String email) =>
      _account.createRecovery(email: email, url: Constant.baseUrl);

  Future<dynamic> deleteSession(String sessionId) =>
      _account.deleteSession(sessionId: sessionId);

  Future<DocumentList> incidences(
          List<dynamic> queries, int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.incidencesId,
          queries: queries,
          limit: limit,
          offset: offset);

  Future<Document> incidence(String incidenceId) => _database.getDocument(
      collectionId: Constant.incidencesId, documentId: incidenceId);

  Future<Document> incidenceCreate(Incidence incidence) =>
      _database.createDocument(
          collectionId: Constant.incidencesId,
          documentId: 'unique()',
          data: incidenceToJson(incidence),
          read: ['role:member'],
          write: ['role:member']);

  Future<Document> user(String userId) =>
      _database.getDocument(collectionId: Constant.usersId, documentId: userId);

  Future<File> createFile(Uint8List uint8list, String name) =>
      _storage.createFile(
          bucketId: Constant.buckedId,
          fileId: 'unique()',
          file: InputFile(
              file: MultipartFile.fromBytes('file', uint8list,
                  filename: name, contentType: MediaType('image', 'jpg'))),
          read: ['role:all'],
          write: ['role:all']);

  Future<DocumentList> prioritys(int limit, int offset) =>
      _database.listDocuments(
          collectionId: Constant.prioritysId, limit: limit, offset: offset);
}
