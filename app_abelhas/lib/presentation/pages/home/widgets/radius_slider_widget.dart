import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadiusSliderWidget extends StatelessWidget {
  final HomeCubit cubit;
  const RadiusSliderWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Raio de aplicação',
            ),
            Slider(
              value: cubit.radius,
              min: 100,
              max: 3000,
              divisions: 49,
              onChanged: cubit.updateRadius,
              label: cubit.radius < 1000
                  ? '${cubit.radius.toInt()} metros'
                  : '${(cubit.radius / 1000).toStringAsFixed(1)} km',
            ),
          ],
        );
      },
    );
  }
}
