import 'package:app_abelhas/core/extensions/color_extension.dart';
import 'package:app_abelhas/core/theme/app_style.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:app_abelhas/presentation/pages/home/widgets/register_agrotoxic_modal.dart';
import 'package:app_abelhas/presentation/pages/home/widgets/register_beehive_modal.dart';
import 'package:app_abelhas/presentation/widgets/custom_modal_widget.dart';
import 'package:app_abelhas/presentation/widgets/custom_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cubit = context.read<HomeCubit>();
    final appStyle = Theme.of(context).extension<AppStyle>()!;

    return RefreshIndicator(
      onRefresh: () => cubit.loadMap(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<HomeCubit, HomeState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is PlaceRegisteredSuccess ||
                state is PulverizationRegisteredSuccess) {
              context.pop();
              CustomToastWidget.show(
                  type: CustomToastType.success,
                  context: context,
                  title: 'Dados salvos com sucesso!');
            } else if (state is PlaceRegisteredError ||
                state is VerifySafeAgrotoxicError) {
              context.pop();
              CustomToastWidget.show(
                  type: CustomToastType.error,
                  context: context,
                  title: 'Ocorreu um erro ao salvar');
            }
          },
          buildWhen: (previous, current) =>
              current is LoadingMap ||
              current is PermissionError ||
              current is MapLoaded ||
              current is ResgisteringPlace,
          builder: (context, state) {
            if (state is LoadingMap) {
              return Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: appStyle.backgroundColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                    appStyle.primaryColor.color700()),
              ));
            } else if (state is PermissionError) {
              return const Center(
                child: Text(
                  'Permissão negada ou serviço desativado',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            } else if (state is ShowBeehiveInfo) {
              CustomModalWidget.showModal(
                  title: 'Cadastro do Apiário',
                  context: context,
                  autoClose: false,
                  barrierDismissible: false,
                  showCloseButton: true,
                  content: RegisterBeehiveModal(
                    cubit: cubit,
                    beehive: state.beehive,
                    coordenadas: LatLng(double.parse(state.beehive.lat),
                        double.parse(state.beehive.lng)),
                  ));
            }
            return AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: size.width,
              height: state is ResgisteringPlace
                  ? size.height * 0.9
                  : size.height * 0.76,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  onTap: (latlng) {
                    if (state is ResgisteringPlace) {
                      cubit.addPlaceOnMap(latlng);
                      if (cubit.authStateNotifier.user?.type != 'Apicultor') {
                        CustomModalWidget.showModal(
                            title: 'Cadastro do Agrotóxico',
                            context: context,
                            autoClose: false,
                            barrierDismissible: false,
                            showCloseButton: true,
                            content: RegisterAgrotoxicModal(
                              cubit: cubit,
                              coordenadas: latlng,
                            ));
                      } else {
                        CustomModalWidget.showModal(
                            title: 'Cadastro do Apiário',
                            context: context,
                            autoClose: false,
                            barrierDismissible: false,
                            showCloseButton: true,
                            content: RegisterBeehiveModal(
                              cubit: cubit,
                              coordenadas: latlng,
                            ));
                      }
                    }
                  },
                  mapType: MapType.satellite,
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: cubit.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: cubit.currentPosition ?? LatLng(-25.0, -49.0),
                    zoom: 10,
                  ),
                  polygons: cubit.beehives,
                  markers: cubit.markers,
                  circles: cubit.circles,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
