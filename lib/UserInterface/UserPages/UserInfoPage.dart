import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduan_test/ClassAndServices/GeneralServices.dart';
import 'package:graduan_test/ClassAndServices/User/User.dart';
import 'package:graduan_test/ClassAndServices/User/UserServices.dart';
import 'package:graduan_test/UserInterface/AUIComponents/ReusableWidgets.dart';
import 'package:graduan_test/UserInterface/AUIComponents/SnackBars.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatelessWidget {

  const UserInfoPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (context) => UserInfoPagProvider(context: context),
      child: Consumer<UserInfoPagProvider>(
        builder: (context, userInfoPagProvider, child) {
          User? user = userInfoPagProvider._user;
          return Scaffold(
            appBar: ReusableAppBarForText(
              title: "View Profile",
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
              ),
              actionButtons: [
                user == null
                    ? SizedBox.shrink()
                    : IconButton(
                  onPressed: () {
                    UserServices().goToUserUpdateInfoPage(context, user.name);
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
            body: RefreshIndicator(
              color: Colors.blueAccent,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await userInfoPagProvider._doAll();
              },
              child: userInfoPagProvider._isLoading
                  ? ReusableLoadingIndicator()
                  : user == null
                  ? SizedBox(
                height: size.height,
                width: size.width,
                child: Center(
                  child: Text("Failed to get User Data"),
                ),
              )
                  : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LabelTextWidgetForColumn(label: 'ID', value: '${user.id}'),
                          LabelTextWidgetForColumn(label: 'Name', value: user.name),
                          LabelTextWidgetForColumn(label: 'Email', value: user.email),
                          LabelTextWidgetForColumn(
                              label: 'Email Verified At', value: GeneralServices().formatDate(user.emailVerifiedAt)),
                          LabelTextWidgetForColumn(
                              label: 'Created At', value: GeneralServices().formatDate(user.createdAt)),
                          LabelTextWidgetForColumn(
                              label: 'Updated At', value: GeneralServices().formatDate(user.updatedAt)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

  }

}

class UserInfoPagProvider with ChangeNotifier{
  final BuildContext context;

  UserInfoPagProvider({
    required this.context
}){
    _doAll();
  }

  Future<void> _doAll() async {
    _isLoading = true;
    notifyListeners();

    await _getUserInfo();

    _isLoading = false;
    notifyListeners();
  }

  bool _isLoading = false;

  Future<void> _getUserInfo() async{
    ReturnUser? returnUser = await UserServices().getUserInfo();

    if(returnUser == null){
      SnackBarFunctions().showCustomSnackBar(context, "Failed to get user info:  Return Value NULL");
    }else{
      if(returnUser.success == false){
        SnackBarFunctions().showCustomSnackBar(context, "Failed to get user info: ${returnUser.text}");
      }else{
        User? hereUser = returnUser.user;
        if(hereUser == null){
          SnackBarFunctions().showCustomSnackBar(context, "Failed to get user info: User Was Null");
        }else{
          _user = hereUser;
        }
      }
    }


    notifyListeners();
  }

  User? _user;





}