import 'package:app_abelhas/core/helpers/datetime_helper.dart';
import 'package:app_abelhas/data/models/apicultor_area.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:app_abelhas/presentation/pages/home/widgets/radius_slider_widget.dart';
import 'package:app_abelhas/presentation/widgets/custom_button.dart';
import 'package:app_abelhas/presentation/widgets/custom_dropdown.dart';
import 'package:app_abelhas/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegisterAgrotoxicModal extends StatefulWidget {
  final HomeCubit cubit;
  final LatLng coordenadas;
  final SprayArea? area;
  const RegisterAgrotoxicModal(
      {super.key, required this.cubit, required this.coordenadas, this.area});

  @override
  State<RegisterAgrotoxicModal> createState() => _RegisterAgrotoxicModalState();
}

class _RegisterAgrotoxicModalState extends State<RegisterAgrotoxicModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? _validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    try {
      final parts = value.split('/');
      if (parts.length != 3) {
        return 'Data inválida';
      }

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final selectedDate = DateTime(year, month, day);

      if (selectedDate.year != year ||
          selectedDate.month != month ||
          selectedDate.day != day) {
        return 'Data inválida';
      }

      final today = DateTime.now();
      final currentDate = DateTime(today.year, today.month, today.day);

      if (selectedDate.isBefore(currentDate)) {
        return 'A data não pode ser anterior à atual';
      }
    } catch (_) {
      return 'Data inválida';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: widget.cubit,
                  builder: (context, state) {
                    return GoogleMap(
                      zoomControlsEnabled: false,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                      mapType: MapType.satellite,
                      onMapCreated: (controller) => widget.cubit
                          .onMapCreatedRegistration(controller,
                              coordenadas: widget.coordenadas),
                      initialCameraPosition: CameraPosition(
                        target: widget.coordenadas,
                        zoom: 15,
                      ),
                      markers: widget.cubit.markers.isNotEmpty
                          ? {widget.cubit.markers.last}
                          : {},
                      circles: widget.cubit.circles,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            RadiusSliderWidget(
              cubit: widget.cubit,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextFormField(
              label: 'Nome',
              isRequired: true,
              controller: _nameController,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextFormField(
              label: 'Data',
              isRequired: true,
              controller: _dateController,
              fieldType: FieldType.date,
              validator: _validateDate,
            ),
            SizedBox(
              height: 12,
            ),
            CustomDropdown<String>(
              // initialValue: cubit.entregadorSelected?.nome,
              label: 'Grupo de Risco',
              items: ['A', 'B']
                  .map((gd) => DropdownMenuItem<String>(
                        value: gd,
                        child: Text(gd),
                      ))
                  .toList(),
              onChanged: (String? newValue) async {
                widget.cubit.onChangeGrupoRisco(newValue);
              },
            ),
            SizedBox(
              height: 12,
            ),
            CustomDropdown<String>(
              // initialValue: cubit.entregadorSelected?.nome,
              label: 'Tipo de Agrotóxico',
              items: ['Químico', 'Biológico']
                  .map((gd) => DropdownMenuItem<String>(
                        value: gd,
                        child: Text(gd),
                      ))
                  .toList(),
              onChanged: (String? newValue) async {
                widget.cubit.onChangeTipo(newValue);
              },
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
                        widget.cubit.verifySafeAgrotoxic(SprayArea(
                            id: '',
                            name: _nameController.text,
                            lat: widget.coordenadas.latitude.toString(),
                            lng: widget.coordenadas.longitude.toString(),
                            groupRisk: widget.cubit.grupoRisco!,
                            type: widget.cubit.tipoAgrotoxico!,
                            radius: widget.cubit.radius.toString(),
                            date: DateTimeHelper.parseDate(
                                _dateController.text)));
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
                  widget.cubit.cancelRegisterAgrotoxic();
                  context.pop();
                }),
          ],
        ),
      ),
    );
  }
}
