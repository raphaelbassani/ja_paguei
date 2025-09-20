import 'package:dart_either/dart_either.dart';

import '../../l10n/l10n.dart';
import '../datasources/remote/joke_datasource.dart';
import '../errors.dart';
import '../models.dart';
import 'base_service.dart';

class JokeService extends BaseService {
  final JokeDatasource datasource;

  JokeService({required super.languageCode, required this.datasource});

  Future<Either<Failure, JokeModel>> getJoke() async {
    Failure? failure;
    try {
      final response = await datasource.getJoke(languageCode: languageCode);

      return Right(response);
    } on JokeAPIException catch (_) {
      failure = GetJokeAPIFailure(
        message: JPLocale.translate(languageCode, JPLocaleKeys.jokeAPIFailure),
      );
    } on RemoteException catch (_) {
      failure = GetJokeFailure(
        message: JPLocale.translate(
          languageCode,
          JPLocaleKeys.jokeRemoteFailure,
        ),
      );
    } catch (_) {
      failure = UnknownFailure(
        message: JPLocale.translate(languageCode, JPLocaleKeys.unknownFailure),
      );
    }

    return Left(failure);
  }
}
