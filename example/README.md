# hamburger_scaffold_example

Demonstrates how to use the hamburger_scaffold package

### Example

``` dart
import 'package:flutter_hamburger_scaffold/flutter_hamburger_scaffold.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _widget;
  List<HamburgerMenuItem> _menuItems = [new HamburgerMenuItem('Inbox', Icons.inbox, new Inbox()),new HamburgerMenuItem('Starred', Icons.star, new Starred()),new HamburgerMenuItem('Snoozed', Icons.snooze, new Snoozed())];
  @override
  void initState() {
    _widget = _menuItems[0].child;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return HamburgerScaffold(
      appBarTitle: Text('Gmail'.toUpperCase(),style: TextStyle(letterSpacing: 5,fontWeight: FontWeight.w300),),
      centerTitle: true,
      body: _widget,
      hamburgerMenu: new HamburgerMenu(
        onClick: (Widget widget){
          setState(() {
            _widget = widget;
          });
        },
        indicatorColor: Colors.white,
        selectedColor: Theme.of(context).primaryColor,
        unselectedColor: Colors.white,
        children: _menuItems,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
```
