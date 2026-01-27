import 'package:app_abelhas/core/helpers/sizes_helper.dart';
import 'package:app_abelhas/core/theme/app_primitive_colors.dart';
import 'package:app_abelhas/core/theme/font/app_font_size.dart';
import 'package:app_abelhas/core/theme/font/app_font_weight.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:app_abelhas/presentation/pages/home/widgets/meus_dados_item.dart';
import 'package:app_abelhas/presentation/pages/home/widgets/profile_item_widget.dart';
import 'package:app_abelhas/presentation/pages/home/widgets/profile_photo_widget.dart';
import 'package:app_abelhas/presentation/widgets/custom_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // await provider.loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    // final appStyle = Theme.of(context).extension<AppStyle>()!;
    // if (provider.loading) {
    //   return Center(
    //       child: CircularProgressIndicator(
    //     strokeWidth: 2,
    //     backgroundColor: appStyle.backgroundColor,
    //     valueColor:
    //         AlwaysStoppedAnimation<Color>(appStyle.primaryColor.color700()),
    //   ));
    // }

    // final user = provider.user;

    // if (user == null) {
    // return const Center(child: Text("Usuário não encontrado"));
    // }

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: AppPrimitiveColors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 0.5),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                children: [
                  ProfilePhotoWidget(),
                  SizedBox(
                    width: 14,
                  ),
                  SizedBox(
                    width: displayWidth(context) - 168,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.user.name,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.2,
                              overflow: TextOverflow.ellipsis,
                              fontSize: AppFontSize.fontSize400,
                              fontWeight: AppFontWeight.semiBold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          cubit.user.type,
                          maxLines: 1,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: AppFontSize.fontSize300,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Divider(
              height: 0,
              color: Colors.grey.shade300,
            ),
          ),
          Text(
            'Meus dados',
            style: TextStyle(
                fontSize: AppFontSize.fontSize400,
                fontWeight: AppFontWeight.semiBold),
          ),
          SizedBox(
            height: 4,
          ),
          MeusDadosItem(user: cubit.user),
          SizedBox(
            height: 16,
          ),
          Text(
            'Outras informações',
            style: TextStyle(
                fontSize: AppFontSize.fontSize400,
                fontWeight: AppFontWeight.semiBold),
          ),
          SizedBox(
            height: 4,
          ),
          Card(
            color: AppPrimitiveColors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 0.5),
                borderRadius: BorderRadius.circular(12)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ProfileItemWidget(
                  name: 'Termos',
                  icon: Icons.document_scanner_rounded,
                  onTap: () {
                    CustomToastWidget.show(
                        type: CustomToastType.info,
                        context: context,
                        title: 'Funcionalidade não disponível no momento.');
                  }),
              ProfileItemWidget(
                  name: 'Redefinir Senha',
                  icon: Icons.lock_outline_rounded,
                  onTap: () {
                    CustomToastWidget.show(
                        type: CustomToastType.info,
                        context: context,
                        title: 'Funcionalidade não disponível no momento.');
                  }),
              ProfileItemWidget(
                name: 'Sair',
                icon: Icons.logout,
                iconColor: Colors.red,
                onTap: () {
                  context.pushReplacement('/login');
                },
              ),
              SizedBox(
                height: 8,
              )
            ]),
          )
        ],
      ),
    ));
  }
}
