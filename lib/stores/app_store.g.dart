// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$App on AppStore, Store {
  late final _$currentRouteAtom = Atom(name: 'AppStore.currentRoute', context: context);

  @override
  int get currentRoute {
    _$currentRouteAtom.reportRead();
    return super.currentRoute;
  }

  @override
  set currentRoute(int value) {
    _$currentRouteAtom.reportWrite(value, super.currentRoute, () {
      super.currentRoute = value;
    });
  }

  late final _$themeAtom = Atom(name: 'AppStore.theme', context: context);

  @override
  String get theme {
    _$themeAtom.reportRead();
    return super.theme;
  }

  @override
  set theme(String value) {
    _$themeAtom.reportWrite(value, super.theme, () {
      super.theme = value;
    });
  }

  late final _$AppStoreActionController = ActionController(name: 'AppStore', context: context);

  @override
  void increment() {
    final _$actionInfo = _$AppStoreActionController.startAction(name: 'AppStore.increment');
    try {
      return super.increment();
    } finally {
      _$AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentRoute: ${currentRoute},
theme: ${theme}
    ''';
  }
}
