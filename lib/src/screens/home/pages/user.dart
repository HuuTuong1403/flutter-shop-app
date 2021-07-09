import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/common/myicon.dart';
import 'package:shopappfirebase/src/services/authentication_service.dart';
import 'package:shopappfirebase/src/services/customer_service.dart';
import 'package:shopappfirebase/src/services/global_methods.dart';
import 'package:shopappfirebase/src/themes/theme_service.dart';
import 'package:shopappfirebase/src/routes/app_pages.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _value = ThemeService().isSavedDarkMode();
  ScrollController? _scrollController;
  GlobalMethods _globalMethods = GlobalMethods();
  AuthenticationService _auth = AuthenticationService();
  CustomerService _customerService = CustomerService();
  DocumentSnapshot? userDoc;
  String _name = '';
  String _email = '';
  String _phone = '';
  String _joinedAt = '';
  String _imageUrl = '';
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {});
    });
    getData();
  }

  void getData() async {
    bool check = _customerService.isGuest();
    if (check) {
      _name = 'Guest';
      _email = 'No has';
      _joinedAt = 'No has';
      _phone = 'No has';
      _imageUrl =
          'https://cdn.pixabay.com/photo/2016/08/31/11/54/user-1633249_960_720.png';
    } else {
      userDoc = await _customerService.getUserInfo();
      setState(() {
        userDoc!.get('name') != null
            ? _name = userDoc!.get('name')
            : _name = 'Guest';
        userDoc!.get('email') != null
            ? _email = userDoc!.get('email')
            : _email = 'No has';
        userDoc!.get('joinedAt') != null
            ? _joinedAt = userDoc!.get('joinedAt')
            : _joinedAt = 'No has';
        userDoc!.get('phone') != null
            ? _phone = userDoc!.get('phone')
            : _phone = 'No has';
        userDoc!.get('ImageUrl') != null
            ? _imageUrl = userDoc!.get('ImageUrl')
            : _imageUrl =
                'https://cdn.pixabay.com/photo/2016/08/31/11/54/user-1633249_960_720.png';
      });
    }
  }

  var top = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    top = constraints.biggest.height;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [AppColor.starterColor, AppColor.endColor],
                            begin: const FractionalOffset(0, 0),
                            end: const FractionalOffset(1, 0),
                            stops: [0, 1],
                            tileMode: TileMode.clamp),
                      ),
                      child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AnimatedOpacity(
                                opacity: top <= 110.0 ? 1 : 0,
                                duration: Duration(milliseconds: 300),
                                child: Row(children: <Widget>[
                                  SizedBox(width: 12),
                                  Container(
                                    height: kToolbarHeight / 1.8,
                                    width: kToolbarHeight / 1.8,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.white, blurRadius: 1)
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage('$_imageUrl')),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text("$_name",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white))
                                ]),
                              ),
                            ]),
                        background: Image(
                          image: NetworkImage('$_imageUrl'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: _userTitle('User Bag'),
                    ),
                    _userBag(
                        'Wishlist', Routes.WISHLIST, MyIcon.ios_heart_empty),
                    _userBag(
                      'Cart',
                      Routes.CARTPAGE,
                      MyIcon.materialCart,
                    ),
                    _userBag('Order', Routes.ORDER, MyIcon.materialCart),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: _userTitle('User Information'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    _userListTile('Email', '$_email', Icons.mail),
                    _userListTile('Phone number', '$_phone', Icons.phone),
                    _userListTile('Shipping address', '', Icons.local_shipping),
                    _userListTile(
                        'Joined date', '$_joinedAt', Icons.watch_later),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: _userTitle('User settings'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTileSwitch(
                      value: _value,
                      leading: Icon(MyIcon.md_moon),
                      onChanged: (value) {
                        setState(() {
                          _value = !ThemeService().isSavedDarkMode();
                          ThemeService().changeThemeMode();
                        });
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor: Colors.indigo,
                      title: Text('Dark theme'),
                    ),
                    ListTile(
                      title: Text('Logout'),
                      subtitle: Text(''),
                      leading: Icon(Icons.exit_to_app_rounded),
                      onTap: () {
                        _globalMethods.showDialog(
                            title: 'Log Out',
                            subtitle: 'Do you wanna to logout?',
                            fct: () {
                              _auth.logOut(onSuccess: () {
                                Get.back();
                                Get.offAndToNamed(Routes.ROOT);
                              });
                            },
                            context: context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _userBag(String title, String route, IconData icon) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          title: Text(title),
          leading: Icon(icon),
          trailing: Icon(Icons.chevron_right_outlined),
          onTap: () {
            Get.toNamed(route);
          },
        ),
      ),
    );
  }

  Widget _buildFab() {
    final double defaultTopMargin = 200 - 4;
    final double scaleStart = 160;
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1;
    if (_scrollController!.hasClients) {
      double offset = _scrollController!.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        scale = 1;
      } else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        scale = 0;
      }
    }

    return Positioned(
      top: top,
      right: 16,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: 'btn1',
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  Widget _userTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
    );
  }

  Widget _userListTile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(icon),
      onTap: () {},
    );
  }
}
