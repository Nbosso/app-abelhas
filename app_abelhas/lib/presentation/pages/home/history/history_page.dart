import 'package:app_abelhas/core/theme/app_style.dart';
import 'package:app_abelhas/core/theme/font/app_font_size.dart';
import 'package:app_abelhas/core/theme/font/app_font_weight.dart';
import 'package:app_abelhas/data/models/apicultor_area.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:app_abelhas/presentation/widgets/custom_modal_widget.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>()..getHistory();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetHistoryLoading && cubit.history.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }

        if (cubit.history.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Nenhum histórico encontrado'),
                TextButton.icon(
                  onPressed: cubit.getHistory,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Recarregar'),
                )
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.getHistory,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: cubit.history.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = cubit.history[index];
              return _HistoryTile(item: item);
            },
          ),
        );
      },
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final SprayArea item;

  const _HistoryTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final canDisable = cubit.canDisableHistoryItem(item);
    final isLoading = cubit.isDisablingHistoryItem(item.id);
    final appStyle = Theme.of(context).extension<AppStyle>()!;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: item.enable ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name.isEmpty ? 'Aplicação sem nome' : item.name,
                        style: TextStyle(
                            fontSize: AppFontSize.fontSize500,
                            fontWeight: AppFontWeight.semiBold,
                            color: appStyle.primaryColor),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                FeatherIcons.calendar,
                                size: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                _formatDate(item.date),
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize300,
                                  fontWeight: AppFontWeight.medium,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Row(
                            children: [
                              Icon(
                                FeatherIcons.disc,
                                size: 16,
                              ), //target
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${item.radius} m',
                                style: TextStyle(
                                  fontSize: AppFontSize.fontSize300,
                                  fontWeight: AppFontWeight.medium,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Chip(label: Text(item.groupRisk)),
                              Chip(label: Text(item.type)),
                            ],
                          ),
                          Visibility(
                            visible: canDisable,
                            child: IconButton(
                              onPressed: !isLoading
                                  ? () {
                                      CustomModalWidget.showConfirmModal(
                                        context: context,
                                        title: 'Histórico',
                                        message:
                                            'Tem certeza que deseja desativar a aplicação ${item.name}?',
                                        confirmLabel: 'Sim',
                                        cancelLabel: 'Cancelar',
                                        onConfirm: () =>
                                            cubit.disableHistoryItem(item),
                                      );
                                    }
                                  : null,
                              icon: isLoading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    )
                                  : const Icon(Icons.delete_outline_rounded),
                              tooltip: canDisable
                                  ? 'Desativar aplicação'
                                  : 'Apenas aplicações com data futura podem ser desativadas',
                            ),
                          ),
                        ],
                      ),
                      // Text(
                      //   item.enable ? 'Status: Ativo' : 'Status: Desativado',
                      //   style: TextStyle(
                      //     color: item.enable
                      //         ? Colors.green.shade700
                      //         : Colors.grey.shade700,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
