library flutter_hamburger_scaffold;

import 'package:flutter/material.dart';
class HamburgerScaffold extends StatefulWidget{
  final Widget body;
  final Widget appBarTitle;
  final bool centerTitle;
  final HamburgerMenu hamburgerMenu;
  final Color backgroundColor;
  final double menuWidth;
  final Widget appBarBottom;
  final List<Widget> appBarActions;
  HamburgerScaffold({Key key,@required this.body,@required this.hamburgerMenu,this.backgroundColor, this.menuWidth, this.appBarTitle, this.centerTitle, this.appBarActions, this.appBarBottom}) : super(key: key);
  @override
  _HamburgerScaffoldState createState() => _HamburgerScaffoldState();
}
class _HamburgerScaffoldState extends State<HamburgerScaffold> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: widget.appBarTitle != null ? PreferredSize(child: widget.appBarTitle, preferredSize: Size.fromHeight(kToolbarHeight)) : new Container(),
        centerTitle: widget.centerTitle != null ? widget.centerTitle : true,
        bottom: widget.appBarBottom != null ? widget.appBarBottom  : null,
        actions: widget.appBarActions != null ? widget.appBarActions : [],
        leading: InkWell(
          onTap: (){
            setState(() {
              _isExpanded ? _isExpanded = false : _isExpanded = true;
            });
          },
          child: Icon(Icons.menu)),
      ),
      body: new Row(
        children: <Widget>[
          HamburgerDrawer(hamburgerMenu: widget.hamburgerMenu, expanded: _isExpanded),
          Expanded(child: widget.body,)
        ],
      ),
    );
  }
}
class HamburgerDrawer extends StatefulWidget{
  final HamburgerMenu hamburgerMenu;
  final bool expanded;
  HamburgerDrawer({Key key,@required this.hamburgerMenu,@required this.expanded}) : super(key: key);
  @override
  _HamburgerDrawerState createState() => _HamburgerDrawerState();
}

class _HamburgerDrawerState extends State<HamburgerDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(width: widget.expanded ? (kToolbarHeight*3.5) : kToolbarHeight,child: HamburgerMenu(unselectedColor: widget.hamburgerMenu.unselectedColor, selectedColor: widget.hamburgerMenu.selectedColor, indicatorColor: widget.hamburgerMenu.indicatorColor, children: widget.hamburgerMenu.children, onClick: widget.hamburgerMenu.onClick, expanded: widget.expanded));
  }
}
typedef HamburgerMenuCallback(Widget widget);
class HamburgerMenu extends StatefulWidget{
  final Color unselectedColor,selectedColor,indicatorColor;
  final List<HamburgerMenuItem> children;
  final HamburgerMenuCallback onClick;
  final expanded;
  HamburgerMenu({Key key,@required this.unselectedColor,@required this.selectedColor,@required this.indicatorColor,@required this.children,@required this.onClick, this.expanded}) : super(key: key);
  @override
  _HamburgerMenuState createState() => _HamburgerMenuState();
}
class _HamburgerMenuState extends State<HamburgerMenu> {
  int _selectedPosition = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(widget.children.length, (index){
        HamburgerMenuItem _item = widget.children[index];
        bool _isSelected = _selectedPosition == index ? true : false;
        return InkWell(
          onTap: (){
            if(_selectedPosition != index){
              setState(() {
                _selectedPosition = index;
                widget.onClick(_item.child);
              });
            }
          },
          child: widget.expanded ? new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: new Container(
                  color: _isSelected ? widget.indicatorColor : Colors.transparent,
                  height: kToolbarHeight,
                  child: Center(child: Icon(_item.icon,size: 24 ,color: _isSelected ? widget.selectedColor : widget.unselectedColor)),
                ),
                flex: 8,
              ),
              Expanded(
                child: new Container(
                  color: _isSelected ? widget.indicatorColor : Colors.transparent,
                  height: kToolbarHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(_item.title,style: TextStyle(fontSize: 18,color: _isSelected ? widget.selectedColor : widget.unselectedColor),overflow: TextOverflow.fade,),
                    ],
                  ),
                ),
                flex: 20,
              )
            ],
          ):
          new Container(
            color: _isSelected ? widget.indicatorColor : Colors.transparent,
            height: kToolbarHeight,
            child: Tooltip(message: widget.children[index].title,child: Icon(_item.icon,size: 24 ,color: _isSelected ? widget.selectedColor : widget.unselectedColor),),
          ),
        );
      }),
    );
  }
}
class HamburgerMenuItem{
  final String title;
  final IconData icon;
  final Widget child;
  HamburgerMenuItem(this.title, this.icon, this.child);
}
