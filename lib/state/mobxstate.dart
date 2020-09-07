import 'package:mobx/mobx.dart';

part 'mobxstate.g.dart';

/* flutter packages pub run build_runner build */
class MobxState = MobxStateBase with _$MobxState;

abstract class MobxStateBase with Store {

  @observable
  Observable<bool> isDark = Observable(false);

  @computed
  bool get isDarkValue => isDark.value;

  @action
  void toggleDarkMode() {
    isDark = Observable(!isDark.value);
  }
}