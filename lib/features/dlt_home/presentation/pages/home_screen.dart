import 'package:flutter/material.dart';
import 'package:codevidhi_firechat/core/di/injection.dart';
import 'package:codevidhi_firechat/core/localization/extension/loc.dart';
import 'package:codevidhi_firechat/core/router/route_names.dart';
import 'package:codevidhi_firechat/core/theme/typography/text_theme_ext.dart';
import 'package:codevidhi_firechat/core/widgets/app_drawer/app_drawer.dart';
import 'package:codevidhi_firechat/dlt_common_actions/infinite_scrolling/presentation/bloc/post_bloc.dart';
import 'package:codevidhi_firechat/dlt_common_actions/infinite_scrolling/presentation/pages/posts_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.loc.home, style: context.headlineMedium),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () => context.goNamed(RouteNames.notifications),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Dummy List'),
              Tab(text: 'Posts'),
            ],
          ),
        ),
        drawer: const AppDrawer(),
        body: TabBarView(
          children: [
            ListView(
              children: const [
                ListTile(
                  title: Text('Dummy Item 1'),
                ),
                ListTile(
                  title: Text('Dummy Item 2'),
                ),
              ],
            ),
            BlocProvider(
              create: (context) => sl<PostsBloc>(),
              child: const PostsPage(),
            ),
          ],
        ),
      ),
    );
  }
}
