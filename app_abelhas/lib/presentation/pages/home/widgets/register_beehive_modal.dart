import 'package:app_abelhas/data/models/beehive_model.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:app_abelhas/presentation/widgets/custom_button.dart';
import 'package:app_abelhas/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegisterBeehiveModal extends StatefulWidget {
  final HomeCubit cubit;
  final LatLng coordenadas;
  final BeehiveModel? beehive;
  const RegisterBeehiveModal(
      {super.key,
      required this.cubit,
      required this.coordenadas,
      this.beehive});

  @override
  State<RegisterBeehiveModal> createState() => _RegisterBeehiveModalState();
}

class _RegisterBeehiveModalState extends State<RegisterBeehiveModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _registerController = TextEditingController();
  final TextEditingController _responsibleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.beehive != null) {
      _registerController.text = widget.beehive!.register;
      _descriptionController.text = widget.beehive!.description;
      _responsibleController.text = widget.beehive!.responsible;
    } else {
      _responsibleController.text = widget.cubit.user.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                zoomGesturesEnabled: false,
                mapType: MapType.satellite,
                onMapCreated: (controller) => widget.cubit
                    .onMapCreated(controller, coordenadas: widget.coordenadas),
                initialCameraPosition: CameraPosition(
                  target: widget.coordenadas,
                  zoom: 10,
                ),
                polygons: widget.cubit.beehives,
                markers: widget.cubit.markers,
                circles: widget.cubit.circles,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextFormField(
            label: 'Nome do Apiário',
            isRequired: true,
            controller: _registerController,
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextFormField(
            label: 'Responsável',
            isRequired: true,
            controller: _responsibleController,
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextFormField(
            label: 'Descrição',
            controller: _descriptionController,
            minLines: 2,
            maxLines: 3,
          ),
          SizedBox(
            height: 24,
          ),
          BlocBuilder<HomeCubit, HomeState>(
            bloc: widget.cubit,
            builder: (context, state) {
              return CustomButtonWidget(
                  type: CustomButtonType.primary,
                  label: 'Salvar',
                  isLoading: state is LoadingResgisteringPlace,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.cubit.registerPlace(BeehiveModel(
                          id: '',
                          register: _registerController.text,
                          lat: widget.coordenadas.latitude.toString(),
                          lng: widget.coordenadas.longitude.toString(),
                          responsible: _responsibleController.text,
                          description: _descriptionController.text));
                    }
                  });
            },
          ),
          SizedBox(
            height: 12,
          ),
          CustomButtonWidget(
              type: CustomButtonType.secondary,
              label: 'Cancelar',
              onPressed: () {
                widget.cubit.cancelRegisterPlace();
                context.pop();
              }),
        ],
      ),
    );
  }
}
