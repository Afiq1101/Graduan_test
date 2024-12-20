import 'package:flutter/material.dart';
import 'package:graduan_test/ClassAndServices/Post/PostServices.dart';
import 'package:graduan_test/ClassAndServices/User/UserServices.dart';
import 'package:graduan_test/UserInterface/AUIComponents/ReusableWidgets.dart';

class Homepage extends StatelessWidget {
  final VoidCallback logOut;
  const Homepage({Key? key, required this.logOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
          appBar: ReusableAppBarForText(title: "Home Page"),
          body: Container(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableTextButton(text: "View Profile", onPressed: (){
                  UserServices().goToUserInfoPage(context);
                }),
                ReusableTextButton(text: "View Posts", onPressed: (){
                  PostServices().goToViewAllPostsPage(context);
                }),
                ReusableTextButton(text: "Create Post", onPressed: (){
                  PostServices().goToCreatePostPage(context);
                }),
                ReusableTextButton(text: "Log Out", onPressed: (){
                  logOut();
                }),
              ],
            ),
          ),
    );
  }
}

