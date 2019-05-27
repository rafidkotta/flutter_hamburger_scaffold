import 'package:flutter/material.dart';
import 'package:flutter_hamburger_scaffold/flutter_hamburger_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamburger Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Home(),
    );
  }
}

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
      appBarTitle: Text('Gmail',style: TextStyle(letterSpacing: 5,fontWeight: FontWeight.w300),),
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
class Inbox extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: Colors.white,body: Center(child: CircularProgressIndicator(),));
  }

}
class Starred extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(),);
  }

}
class Snoozed extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(),);
  }

}