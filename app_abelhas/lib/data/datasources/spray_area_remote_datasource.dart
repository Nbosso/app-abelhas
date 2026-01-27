import 'dart:developer';

import 'package:app_abelhas/core/services/supabase_service.dart';
import 'package:app_abelhas/data/models/affected_beehive.dart';
import 'package:app_abelhas/data/models/apicultor_area.dart';
import 'package:app_abelhas/data/models/notification_model.dart';

class SprayAreaDatasource {
  final SupabaseService _supabaseService;

  SprayAreaDatasource(this._supabaseService);
  Future<void> save(SprayArea sprayArea) async {
    try {
      await _supabaseService.client
          .from('spray_area')
          .insert(sprayArea.toMap());
    } catch (_) {
      rethrow;
    }
  }

  Future<void> confirmPulverization(
      SprayArea sprayArea, List<AffectedBeehive> affectedBeehives) async {
    try {
      await _supabaseService.client.functions.invoke(
        'confirm_spray_application',
        body: {
          'lat': sprayArea.lat,
          'lng': sprayArea.lng,
          'radius': double.parse(sprayArea.radius).round(),
          'group_risk': sprayArea.groupRisk,
          'pulv_type': sprayArea.type,
          'name': sprayArea.name,
          'affected_user_ids':
              affectedBeehives.map((e) => e.apicultorId).toList(),
        },
      );
    } catch (ex) {
      log('ConfirmPulv:$ex');
      rethrow;
    }
  }

  Future<List<NotificationModel>> getNotifications() async {
    final userId = _supabaseService.client.auth.currentUser?.id;

    if (userId == null) {
      throw Exception('Usuário não autenticado.');
    }
    try {
      final response = await _supabaseService.client
          .from('notifications')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final notifications =
          (response as List).map((e) => NotificationModel.fromMap(e)).toList();
      return notifications;
    } catch (ex) {
      log('GetNotificaitons: $ex');
      return [];
    }
  }
}
