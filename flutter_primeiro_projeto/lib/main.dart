import 'package:flutter/material.dart';
import 'package:flutter_primeiro_projeto/pages/botoes_rotacao_texto/botoes_rotacao_texto_page.dart';
import 'package:flutter_primeiro_projeto/pages/bottom_navigator_bar/bottom_navigator_bar_page.dart';
import 'package:flutter_primeiro_projeto/pages/cidades/cidades_page.dart';
import 'package:flutter_primeiro_projeto/pages/colors/colors_page.dart';
import 'package:flutter_primeiro_projeto/pages/container/container_page.dart';
import 'package:flutter_primeiro_projeto/pages/desafio/pages/desafio_page.dart';
import 'package:flutter_primeiro_projeto/pages/dialogs/dialogs_page.dart';
import 'package:flutter_primeiro_projeto/pages/forms/forms_page.dart';
import 'package:flutter_primeiro_projeto/pages/home/home_page.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:flutter_primeiro_projeto/pages/layout_builder/layout_builder_page.dart';
import 'package:flutter_primeiro_projeto/pages/material_banner/material_banner_page..dart';
import 'package:flutter_primeiro_projeto/pages/scrolls/listview_page.dart';
import 'package:flutter_primeiro_projeto/pages/scrolls/singlechildscrollview_page.dart';
import 'package:flutter_primeiro_projeto/pages/snackbar/snackbar_page.dart';
import 'package:flutter_primeiro_projeto/pages/stack/stack_page.dart';

import 'pages/circle_avatar/circle_avatar_page.dart';
import 'pages/media_query/media_query_page.dart';
import 'pages/rows_columns/rows_columns_page.dart';
import 'pages/stack/stack_page2.dart';

//void main() => runApp(
//  DevicePreview(
//    enabled: false,
//    builder: (BuildContext context) => MyApp(), 
//  ),
//);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //useInheritedMediaQuery: true,
      //locale: DevicePreview	.locale(context),
      //builder: DevicePreview.appBuilder,
      title: 'Flutter Primero Projeto',
      theme: ThemeData(
        primaryColor: Colors.amber,
        primarySwatch: Colors.green,
      ),
      //darkTheme: ThemeData.dark(),
      routes: {
        '/': (_) => const HomePage(),
        '/container': (_) => const ContainerPage(),
        '/rows_columns': (_) => const RowsColumnsPage(),
        '/media_query': (_) => const MediaQueryPage(),
        '/layout_builder': (_) => const LayoutBuilderPage(),
        '/botoes_rotacao_texto': (_) => const BotoesRotacaoTextoPage(),
        '/scrolls/single_child': (_) => const SinglechildscrollviewPage(),
        '/scrolls/list_view': (_) => const ListviewPage(),
        '/dialogs': (_) => const DialogsPage(),
        '/snackbars': (_) => const SnackbarPage(),
        '/forms':(_) => const FormsPage(),
        '/cidades': (_) => const CidadesPage(),
        '/stack': (_) => const StackPage(),
        '/stack/stack2': (_) => const StackPage2(),
        '/bottomNavigatorBar': (_) => const BottomNavigatorBarPage(),
        '/circleAvatar': (_) => const CircleAvatarPage(),
        '/colors': (_) => const ColorsPage(),
        '/materialBanner': (_) => const MaterialBannerPage(),
        '/desafio': (_) => const DesafioPage(),
      },
    );
  }
}

