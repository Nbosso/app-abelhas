import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

enum HomeTabItensEntity { home, notifications, configuracoes, profile }

extension HomeTabItensDetails on HomeTabItensEntity {
  String get title {
    switch (this) {
      case HomeTabItensEntity.home:
        return 'BeeAlert';
      case HomeTabItensEntity.notifications:
        return 'Notificações';
      case HomeTabItensEntity.configuracoes:
        return 'Configurações';
      case HomeTabItensEntity.profile:
        return 'Perfil';
    }
  }

  String get label {
    switch (this) {
      case HomeTabItensEntity.home:
        return 'Mapa';
      case HomeTabItensEntity.notifications:
        return 'Notificações';
      case HomeTabItensEntity.configuracoes:
        return 'Configurações';
      case HomeTabItensEntity.profile:
        return 'Perfil';
    }
  }

  IconData get icon {
    switch (this) {
      case HomeTabItensEntity.home:
        return FeatherIcons.map;
      case HomeTabItensEntity.notifications:
        return FeatherIcons.bell;
      case HomeTabItensEntity.configuracoes:
        return FeatherIcons.settings;
      case HomeTabItensEntity.profile:
        return FeatherIcons.user;
    }
  }
}
