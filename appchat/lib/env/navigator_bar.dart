import 'package:states_rebuilder/states_rebuilder.dart';

class NavigationBarState extends StatesRebuilder {
  int lastPageIndex = 1;
  int pageIndex = 1;

  void onChangeIndex(int index) {
    this.pageIndex = index;
    print(index);
    rebuildStates();
  }

  void onBack(){
    this.pageIndex = lastPageIndex;
  }
}