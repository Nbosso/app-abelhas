import 'dart:developer';

import 'package:app_abelhas/core/services/supabase_service.dart';
import 'package:app_abelhas/data/models/affected_beehive.dart';
import 'package:app_abelhas/data/models/apicultor_area.dart';
import 'package:app_abelhas/data/models/beehive_model.dart';

class BeehiveDatasource {
  final SupabaseService _supabaseService;

  BeehiveDatasource(this._supabaseService);
  Future<void> save(BeehiveModel beehive) async {
    try {
      await _supabaseService.client.from('beehive').insert({
        'register': beehive.register,
        'responsible': beehive.responsible,
        'lat': beehive.lat,
        'lng': beehive.lng,
        'description': beehive.description,
      });
    } catch (_) {
      rethrow;
    }
  }

  Future<List<BeehiveModel>> getUserBeehives() async {
    final userId = _supabaseService.client.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('Usuário não autenticado.');
    }

    final response = await _supabaseService.client
        .from('beehive')
        .select()
        .eq('created_by', userId);

    List<BeehiveModel> list = [];
    for (var item in response) {
      list.add(BeehiveModel.fromMap(item));
    }
    return list;
  }

  Future<List<AffectedBeehive>> verifySafeAgrotoxic(SprayArea sprayArea) async {
    try {
      final response = await _supabaseService.client.rpc(
        'check_pulverization_impact',
        params: {
          'p_application_radius': double.parse(sprayArea.radius).round(),
          'p_lat': double.parse(sprayArea.lat),
          'p_lng': double.parse(sprayArea.lng),
        },
      );

      final affectedBeehives =
          (response as List).map((e) => AffectedBeehive.fromMap(e)).toList();

      return affectedBeehives;
    } catch (ex) {
      log('CheckPulv: $ex');
    }
    return [];
  }
}
