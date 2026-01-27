import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:app_abelhas/presentation/widgets/custom_toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    context.read<HomeCubit>().getAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeCubit>();

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Localização',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        value: true,
                        onChanged: (value) {
                          CustomToastWidget.show(
                              type: CustomToastType.info,
                              context: context,
                              title:
                                  'Funcionalidade não disponível no momento.');
                        })),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notificações',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        value: true,
                        onChanged: (value) {
                          CustomToastWidget.show(
                              type: CustomToastType.info,
                              context: context,
                              title:
                                  'Funcionalidade não disponível no momento.');
                        })),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Versão do app',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Text(context.read<HomeCubit>().version);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
