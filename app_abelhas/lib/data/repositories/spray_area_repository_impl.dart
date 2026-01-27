import 'package:app_abelhas/core/errors/failures.dart';
import 'package:app_abelhas/data/datasources/spray_area_remote_datasource.dart';
import 'package:app_abelhas/data/models/affected_beehive.dart';
import 'package:app_abelhas/data/models/apicultor_area.dart';
import 'package:app_abelhas/data/models/notification_model.dart';
import 'package:dartz/dartz.dart';

abstract class SprayAreaRepository {
  Future<Either<Failure, void>> save(SprayArea sprayArea);
  Future<Either<Failure, void>> confirmPulverization(
      SprayArea sprayArea, List<AffectedBeehive> affectedBeehives);
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
}

class SprayAreaRepositoryImpl implements SprayAreaRepository {
  final SprayAreaDatasource _sprayAreaDatasource;

  SprayAreaRepositoryImpl(this._sprayAreaDatasource);

  @override
  Future<Either<Failure, void>> save(SprayArea sprayArea) async {
    try {
      await _sprayAreaDatasource.save(sprayArea);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPulverization(
      SprayArea sprayArea, List<AffectedBeehive> affectedBeehives) async {
    try {
      await _sprayAreaDatasource.confirmPulverization(
          sprayArea, affectedBeehives);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await _sprayAreaDatasource.getNotifications();
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
