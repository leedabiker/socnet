import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socnet_leewr/pages/activity_feed.dart';
import 'package:socnet_leewr/pages/timeline.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false; // which state to display based on authenticated or not
  late PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    //detect when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    // Reauthenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  // set state based on initial sign in or re-auth when app is closed/reopened
  handleSignIn(GoogleSignInAccount? account) {
    if (account != null) {
      print('User signed in: $account');
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  @override
  void dispose() {
    // called with this object is removed
    pageController.dispose();
    super.dispose();
  }

  // called when user taps sign-in image
  login() {
    googleSignIn.signIn();
  }

  // called when user tap log out, in auth screen
  logout() {
    googleSignIn.signOut();
  }

  //
  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Timeline(),
          ActivityFeed(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex:
            pageIndex, // get the curren active page from the tracked variable pageIndex
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
        ],
      ),
    );

    /*return ElevatedButton(
      child: Text('Logout'),
      onPressed: logout,
    );*/
  }

  // on tap of bottom bar - change the page
  onTap(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'SocNet',
              style: TextStyle(
                fontSize: 90.0,
                fontFamily: "Billabong",
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen(); //Text("Home!!!!");
  }
}
