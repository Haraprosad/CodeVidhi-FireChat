import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codevidhi_firechat/core/bloc/navigation_bloc.dart';
import 'package:codevidhi_firechat/core/bloc/navigation_event.dart';
import 'package:codevidhi_firechat/core/bloc/navigation_state.dart';
import 'package:codevidhi_firechat/core/router/route_names.dart';
import 'package:codevidhi_firechat/core/router/route_paths.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNav({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext ctx) => sl<NavigationBloc>(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _calculateSelectedIndex(context),
              onTap: (index) => _onItemTapped(index, context),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chats',
                ),
  
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    if (location.startsWith(RoutePaths.settings)) return 1;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    context.read<NavigationBloc>().add(NavigationTabChanged(index));

    switch (index) {
      case 0:
        context.goNamed(RouteNames.chats);
        break;
      case 1:
        context.goNamed(RouteNames.settings);
        break;
    }
  }
}
