import 'package:app_abelhas/core/di/service_locator.dart';
import 'package:app_abelhas/domain/entities/home_tab_itens_entity.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:app_abelhas/presentation/pages/home/map/map_page.dart';
import 'package:app_abelhas/presentation/pages/home/notifications/notifications_page.dart';
import 'package:app_abelhas/presentation/pages/home/profile/profile_page.dart';
import 'package:app_abelhas/presentation/pages/home/widgets/bottom_navigation_bar.dart';
import 'package:app_abelhas/presentation/pages/settings/settings_page.dart';
import 'package:app_abelhas/presentation/widgets/custom_button.dart';
import 'package:app_abelhas/presentation/widgets/custom_modal_widget.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = getIt.get<HomeCubit>();
    _cubit.loadMap();
  }

  static final List<Widget> _pages = [
    const MapPage(),
    const NotificationsPage(),
    SettingsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            current is ShowMessageToRegisterPlace ||
            current is VerifySafeAgrotoxicAlert,
        listener: (context, state) {
          if (state is ShowMessageToRegisterPlace) {
            CustomModalWidget.showConfirmModal(
              context: context,
              message: state.message,
              title: 'Cadastrar',
              confirmLabel: 'Ok',
              cancelLabel: 'Cancelar',
              onConfirm: () async => _cubit.registeringPlace(),
            );
          }
          if (state is VerifySafeAgrotoxicAlert) {
            CustomModalWidget.showConfirmModal(
              context: context,
              title: 'Alerta',
              iconPath: Icons.warning_outlined,
              message:
                  'Foram encontrados ${state.numBeehives} apiários no raio de risco. Ao confirmar os apicultores afetados serão alertados do risco.\nDeseja continuar?',
              confirmLabel: 'Confirmar',
              cancelLabel: 'Cancelar',
              onConfirm: () => _cubit.confirmPulverization(),
              onCancel: () async => context.pop(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: _cubit.currentIndex == 0,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 36,
                        ),
                      )),
                  Text(
                    HomeTabItensEntity.values[_cubit.currentIndex].title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: state is ResgisteringPlace
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: CustomButtonWidget(
                        type: CustomButtonType.primary,
                        label: 'Cancelar',
                        onPressed: () {
                          _cubit.cancelRegisterPlace();
                        }),
                  )
                : HomeTabItensEntity.values[_cubit.currentIndex] ==
                        HomeTabItensEntity.home
                    ? FloatingActionButton.extended(
                        extendedPadding: EdgeInsets.symmetric(horizontal: 12),
                        foregroundColor: Colors.green.shade700,
                        backgroundColor: Colors.green.shade100,
                        onPressed: () {
                          _cubit.showMessageToRegisterPlace();
                        },
                        label: SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FeatherIcons.mapPin,
                                size: 18,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Cadastrar',
                                style: TextStyle(
                                    height: 1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      )
                    : null,
            bottomNavigationBar: state is ResgisteringPlace
                ? null
                : HomeBottomNavigatorWidget(
                    tabItems: HomeTabItensEntity.values,
                  ),
            body: _pages[_cubit.currentIndex],
          );
        },
      ),
    );
  }
}
