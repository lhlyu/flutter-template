import 'package:mobx/mobx.dart';

/// `part`指令用于将一个文件的内容视为另一个文件的一部分
part 'app_store.g.dart';

class App = AppStore with _$App;

abstract class AppStore with Store {
  /// 当前路由
  @observable
  int currentRoute = 0;

  /// 当前主题
  @observable
  String theme = 'light';

  @action
  void increment() {}
}
