// --- BIBLIOTECAS DA LINGUAGEM
import 'package:app_abelhas/data/models/notification_model.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class NotificationsPageDois extends StatefulWidget {
//   const NotificationsPageDois({super.key});

//   @override
//   State<NotificationsPageDois> createState() => _NotificationsPageDoisState();
// }

// class _NotificationsPageDoisState extends State<NotificationsPageDois> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _cubit = context.read<HomeCubit>();

//     final groupKeys = _cubit.notifications.keys.toList().reversed.toList();
//     return RefreshIndicator(
//       // onRefresh: () => cubit.getNotificacoes(),
//       onRefresh: () => _cubit.getNotifications(),
//       child: Visibility(
//         visible: _cubit.notifications.isNotEmpty,
//         replacement: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [Text('Você não possui notificações no momento')],
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Visibility(
//             //   // visible: state.selectNotificationsIsEnabled,
//             //   replacement: TextButton(
//             //       // onPressed: () => cubit.toggleSelectNotifications(),
//             //       onPressed: () {},
//             //       child: Text(
//             //         'Selecionar',
//             //         style: TextStyle(
//             //           color: Colors.black,
//             //           fontSize: 16,
//             //           fontWeight: FontWeight.w600,
//             //         ),
//             //       )),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: [
//             //       // Row(
//             //       //   children: [
//             //       //     // Padding(
//             //       //     //   padding: const EdgeInsets.only(right: 2.0),
//             //       //     //   child: Checkbox.adaptive(
//             //       //     //       value: state.isSelectAllNotifications,
//             //       //     //       activeColor: Colors.blue,
//             //       //     //       onChanged: (value) =>
//             //       //     //           cubit.selectAllNotifications()),
//             //       //     // ),
//             //       //     Text(
//             //       //       'Selecionar Todas',
//             //       //       style: TextStyle(
//             //       //         fontSize: 16,
//             //       //         fontWeight: FontWeight.w600,
//             //       //       ),
//             //       //     )
//             //       //   ],
//             //       // ),
//             //       // TextButton(
//             //       //     // onPressed: () => cubit.toggleSelectNotifications(),
//             //       //     onPressed: () {},
//             //       //     child: Text(
//             //       //       'Cancelar',
//             //       //       style: TextStyle(
//             //       //         color: Colors.black,
//             //       //         fontSize: 16,
//             //       //         fontWeight: FontWeight.w600,
//             //       //         // fontFamily: FontsApp.FONT_INTER,
//             //       //       ),
//             //       //     ))
//             //     ],
//             //   ),
//             // ),
//             // const SizedBox(
//             //   height: 12,
//             // ),
//             Expanded(
//               child: ListView.builder(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   itemCount: groupKeys.length,
//                   itemBuilder: (context, index) {
//                     final dateKey = groupKeys[index];
//                     final items = _cubit.notifications[dateKey]!;
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 8.0, horizontal: 16.0),
//                           child: Text(
//                             dateKey,
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                         ...items.map((notification) {
//                           return CardNotificacoes(
//                             notification: notification,
//                             selectNotificationsIsEnabled:
//                                 _cubit.selectNotificationsIsEnabled,
//                             isSelected: _cubit.selectedNotifications
//                                 .contains(notification.id),
//                           );
//                         }),
//                         SizedBox(
//                           height: 32,
//                         )
//                       ],
//                     );
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetNotificationsLoading) {
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
          ));
        }
        return Visibility(
          visible: cubit.notifications.isNotEmpty,
          replacement: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Você não possui notificações no momento'),
              TextButton.icon(
                onPressed: () => cubit.getNotifications(),
                label: Text('Recarregar'),
                icon: Icon(Icons.refresh_rounded),
              )
            ],
          )),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: cubit.notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final notification = cubit.notifications[index];
              return _NotificationTile(notification: notification);
            },
          ),
        );
      },
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context
        //     .read<NotificationsProvider>()
        //     .markAsRead(notification);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              notification.read ? Colors.grey.shade100 : Colors.green.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.read
                ? Colors.grey.shade300
                : Colors.green.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: TextStyle(
                fontWeight:
                    notification.read ? FontWeight.w500 : FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              notification.message,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _formatDate(notification.createdAt),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}
