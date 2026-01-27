import 'package:app_abelhas/domain/entities/home_tab_itens_entity.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomNavigatorWidget extends StatefulWidget {
  const HomeBottomNavigatorWidget({super.key, required this.tabItems});
  final List<HomeTabItensEntity> tabItems;
  @override
  State<HomeBottomNavigatorWidget> createState() =>
      _HomeBottomNavigatorWidgetState();
}

class _HomeBottomNavigatorWidgetState extends State<HomeBottomNavigatorWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    final tabItems = HomeTabItensEntity.values;

    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300))),
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: context.watch<HomeCubit>().currentIndex,
            onTap: cubit.changeTab,
            showUnselectedLabels: false,
            items: tabItems.map((tab) {
              return BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
