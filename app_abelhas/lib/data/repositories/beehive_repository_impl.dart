import 'package:app_abelhas/core/errors/failures.dart';
import 'package:app_abelhas/data/datasources/beehive_remote_datasource.dart';
import 'package:app_abelhas/data/models/affected_beehive.dart';
import 'package:app_abelhas/data/models/apicultor_area.dart';
import 'package:app_abelhas/data/models/beehive_model.dart';
import 'package:dartz/dartz.dart';

abstract class BeehiveRepository {
  Future<Either<Failure, void>> save(BeehiveModel beehive);
  Future<Either<Failure, List<BeehiveModel>>> getUserBeehives();
  Future<Either<Failure, List<AffectedBeehive>>> verifySafeAgrotoxic(
      SprayArea sprayArea);
}

class BeehiveRepositoryImpl implements BeehiveRepository {
  final BeehiveDatasource _beehiveDatasource;

  BeehiveRepositoryImpl(this._beehiveDatasource);

  @override
  Future<Either<Failure, void>> save(BeehiveModel beehive) async {
    try {
      await _beehiveDatasource.save(beehive);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BeehiveModel>>> getUserBeehives() async {
    try {
      final result = await _beehiveDatasource.getUserBeehives();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AffectedBeehive>>> verifySafeAgrotoxic(
      SprayArea sprayArea) async {
    try {
      final result = await _beehiveDatasource.verifySafeAgrotoxic(sprayArea);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
