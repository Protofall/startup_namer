// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobxstate.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MobxState on MobxStateBase, Store {
  final _$isDarkAtom = Atom(name: 'MobxStateBase.isDark');

  @override
  Observable<bool> get isDark {
    _$isDarkAtom.reportRead();
    return super.isDark;
  }

  @override
  set isDark(Observable<bool> value) {
    _$isDarkAtom.reportWrite(value, super.isDark, () {
      super.isDark = value;
    });
  }

  final _$MobxStateBaseActionController =
      ActionController(name: 'MobxStateBase');

  @override
  void toggleDarkMode() {
    final _$actionInfo = _$MobxStateBaseActionController.startAction(
        name: 'MobxStateBase.toggleDarkMode');
    try {
      return super.toggleDarkMode();
    } finally {
      _$MobxStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDark: ${isDark}
    ''';
  }
}
