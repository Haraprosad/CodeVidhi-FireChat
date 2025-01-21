import 'package:codevidhi_firechat/features/chats/presentation/widgets/chats_content.dart';
import 'package:flutter/material.dart';
import 'package:codevidhi_firechat/core/di/injection.dart';
import 'package:codevidhi_firechat/core/localization/extension/loc.dart';
import 'package:codevidhi_firechat/core/theme/typography/text_theme_ext.dart';
import 'package:codevidhi_firechat/core/widgets/app_drawer/app_drawer.dart';
import 'package:codevidhi_firechat/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireChat", style: context.headlineSmall),
        centerTitle: false,
      ),
      drawer: const AppDrawer(),
      body: BlocProvider(
        create: (context) => sl<ChatsBloc>(),
        child: const ChatsContent(),
      ),
    );
  }
}
