import 'package:app_abelhas/core/helpers/sizes_helper.dart';
import 'package:app_abelhas/core/theme/app_primitive_colors.dart';
import 'package:app_abelhas/core/theme/font/app_font_size.dart';
import 'package:app_abelhas/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeusDadosItem extends StatelessWidget {
  final UserModel user;
  const MeusDadosItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // var cubit = context.read<ProfileCubit>();
    return Card(
        color: AppPrimitiveColors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 0.5),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'E-mail',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                ),
                Text(
                  user.email,
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: AppFontSize.fontSize400,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: displayWidth(context) / 2 - 36,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Telefone',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            user.phone,
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: displayWidth(context) / 2 - 36,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Data de Nascimento',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(user.birthDate ?? DateTime.now()),
                            style: TextStyle(
                              fontSize: AppFontSize.fontSize400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
