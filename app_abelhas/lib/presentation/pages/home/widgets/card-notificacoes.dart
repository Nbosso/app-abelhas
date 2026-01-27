import 'package:app_abelhas/core/theme/app_primitive_colors.dart';
import 'package:app_abelhas/domain/entities/notification_entity.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardNotificacoes extends StatefulWidget {
  CardNotificacoes(
      {required this.notification,
      required this.isSelected,
      required this.selectNotificationsIsEnabled});
  final NotificationEntity notification;
  final bool isSelected;
  final bool selectNotificationsIsEnabled;

  @override
  State<CardNotificacoes> createState() => _CardNotificacoesState();
}

class _CardNotificacoesState extends State<CardNotificacoes> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<HomeCubit>();

    return Card(
      elevation: 5,
      color: AppPrimitiveColors.white,
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        childrenPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onExpansionChanged: (value) {
          setState(() {
            isCollapsed = !value;
          });
        },
        leading: Visibility(
          visible: !widget.selectNotificationsIsEnabled,
          replacement: Checkbox.adaptive(
            value: widget.isSelected,
            activeColor: Colors.blue,
            onChanged: (value) {},
          ),
          // onChanged: (value) =>
          //     cubit.selectNotification(widget.notification.id)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 48,
              width: 48,
              color: widget.notification.type.color,
              child: Icon(widget.notification.type.icon),
            ),
          ),
        ),
        subtitle: SizedBox.shrink(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.notification.date.length == 16
                  ? widget.notification.date.substring(11, 16)
                  : '',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              widget.notification.title,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        children: [
          Text(
            widget.notification.message,
            maxLines: 10,
            style:
                TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: !widget.selectNotificationsIsEnabled,
                child: TextButton.icon(
                  // onPressed: () =>
                  //     cubit.deleteNotification(widget.notification.id),
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ),
                  label: Text(
                    'Excluir',
                    style: TextStyle(color: Colors.red),
                  ),
                  style: ButtonStyle(
                    overlayColor: WidgetStateColor.resolveWith(
                        (states) => Colors.red[100]!),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
