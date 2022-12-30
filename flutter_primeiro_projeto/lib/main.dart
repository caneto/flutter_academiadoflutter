import 'package:flutter/material.dart';
import 'package:flutter_primeiro_projeto/pages/container/container_page.dart';
import 'package:flutter_primeiro_projeto/pages/home/home_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_primeiro_projeto/pages/layout_builder/layout_builder_page.dart';

import 'pages/media_query/media_query_page.dart';
import 'pages/rows_columns/rows_columns_page.dart';

void main() => runApp(
  DevicePreview(
    enabled: false,
    builder: (BuildContext context) => MyApp(), 
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //useInheritedMediaQuery: true,
      locale: DevicePreview	.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Primero Projeto',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routes: {
        '/': (_) => const HomePage(),
        '/container': (_) => const ContainerPage(),
        '/rows_columns': (_) => const RowsColumnsPage(),
        '/media_query': (_) => const MediaQueryPage(),
        '/layout_builder': (_) => const LayoutBuilderPage(),
      },
    );
  }
}

