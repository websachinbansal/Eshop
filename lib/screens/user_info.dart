import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/dark_theme_provider.dart';
import 'package:flutter_shop_app/screens/cart.dart';
import 'package:flutter_shop_app/screens/wishlist.dart';
import 'package:flutter_shop_app/services/global_methods.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import '../consts/colors.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  ////////////////////////variables///////////////////////////////////////////
  late ScrollController _scrollController;
  GlobalMethods globalMethods = GlobalMethods();
  var top = 0.0;
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String _uid;
  String _name = 'Loading...';
  String _email = 'Loading...';
  String _joinedAt = '';
  String _userimageUrl = '';
  int _phoneNumber = 1234567890;
  ////////////////////////variables///////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    _auth = FirebaseAuth.instance;
    getData(); // Invoke getData here
  }

 void getData() async {
  User? user = _auth.currentUser;
  if (user == null) {
    print('No user is currently logged in');
    return;
  }
  _uid = user.uid;
  print('User ID: $_uid');
  if (user.email != null) {
    print('User email: ${user.email}');
  } else {
    print('User email is null');
  }
  print('Mobile number: ${user.phoneNumber ?? 'No phone number available'}');
  try {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        _name = userDoc.get('name');
        _email = user.email!;
        _joinedAt = userDoc.get('joinedAt');
        _phoneNumber = userDoc.get('phoneNumber');
        _userimageUrl = userDoc.get('imageUrl') ??
            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg';
      });
      print('Data loaded successfully:');
      print('Name: $_name');
      print('Email: $_email');
      print('Joined At: $_joinedAt');
      print('Phone Number: $_phoneNumber');
    } else {
      print('Document does not exist');
      setState(() {
        _name = 'Document does not exist';
        _email = user.email!;
        _joinedAt = 'N/A';
        _phoneNumber = 0;
        _userimageUrl =
            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg';
      });
    }
  } catch (e) {
    print('Error fetching user document: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    print('Building UI with email: $_email'); // Debug print statement
    return Scaffold(
      body: Stack(
        children: [
          _buildFab(),
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                leading: const Icon(Icons.abc),
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            ColorsConsts.starterColor,
                            ColorsConsts.endColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red,
                                        blurRadius: 15.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  _name.isNotEmpty ? _name : 'Guest',
                                  style: const TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      background: const Image(
                        image: NetworkImage(
                            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle(title: 'User Bag')),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(WishListScreen.routeName),
                        title: const Text('WishList'),
                        trailing: const Icon(Icons.chevron_right),
                        leading: const Icon(Icons.shop),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(Cart.routeName);
                        },
                        title: const Text('Cart'),
                        trailing: const Icon(Icons.chevron_right),
                        leading: const Icon(Icons.shop_2),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle(title: 'User Information')),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile('Email', _email, 0, context),
                    userListTile(
                        'Phone number', _phoneNumber.toString(), 1, context),
                    userListTile('Shipping address', '', 2, context),
                    userListTile('Joined date', _joinedAt, 3, context),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle(title: 'User Bag'),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTileSwitch(
                      value: themeChange.darkTheme,
                      leading: const Icon(Icons.mood),
                      onChanged: (value) {
                        setState(() {
                          themeChange.darkTheme = value;
                        });
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor: Colors.indigo,
                      title: const Text('Dark theme'),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: Image.network(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl1pnlgTN51xoAni23E1MHpS6kdhItU3K-y7Q2TcRZgVUuunf0r4WoqwbCMQ&s',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      const Text('SignOut'),
                                    ],
                                  ),
                                  content:
                                      const Text('Do you want to sign out?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () async {
                                          await _auth.signOut().then(
                                                (value) =>
                                                    Navigator.pop(context),
                                              );
                                        },
                                        child: const Text(
                                          'Ok',
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ],
                                );
                              });
                        },
                        title: const Text('LogOut'),
                        leading: const Icon(Icons.get_app_rounded),
                      ),
                    ),
                    // userListTile('Logout', '', 4, context),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    const double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    const double scaleStart = 160.0;
    //pixels from top where scaling should end
    const double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          onPressed: () {},
          child: const Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  final List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded
  ];

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {},
        title: Text(title),
        subtitle: Text(subTitle.isNotEmpty ? subTitle : 'Not Available'),
        leading: Icon(_userTileIcons[index]),
      ),
    );
  }

  Widget userTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
