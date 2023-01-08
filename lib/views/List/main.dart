// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPokemonList extends StatelessWidget {
  const ViewPokemonList({Key? key}) : super(key: key);

  static const String homeRoute = '/home';
  static const String secondPageRoute = '/home/item';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      restorationScopeId: 'navigator',
      initialRoute: ViewPokemonList.homeRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case ViewPokemonList.homeRoute:
            return _NoAnimationCupertinoPageRoute<void>(
              title: "Lista de pokemones",
              settings: settings,
              builder: (context) => _FirstPage(),
            );
          case ViewPokemonList.secondPageRoute:
            final arguments = settings.arguments as Map<dynamic, dynamic>;
            final title = arguments['pageTitle'] as String?;
            return CupertinoPageRoute<void>(
              title: title,
              settings: settings,
              builder: (context) => _SecondPage(),
            );
        }
        return null;
      },
    );
  }
}

class _FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    achorLik(index) {
      Navigator.of(context).restorablePushNamed<void>(
        ViewPokemonList.secondPageRoute,
        arguments: {
          'pageTitle': "hola mundo $index",
          'body': "este e el context del item $index"
        },
      );
    }

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            automaticallyImplyLeading: false,
          ),
          SliverPadding(
            padding:
                MediaQuery.of(context).removePadding(removeTop: true).padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final title = "page";

                  return ListTile(
                    onTap: () {
                      achorLik(index);
                    },
                    title: Text(title),
                  );
                },
                childCount: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Text(arguments["body"]),
            Text('Personal Info'),
            Text('Personal Info'),
          ],
        ),
      ),
    );
  }
}

/// A CupertinoPageRoute without any transition animations.
class _NoAnimationCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  _NoAnimationCupertinoPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    String? title,
  }) : super(
          builder: builder,
          settings: settings,
          title: title,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
