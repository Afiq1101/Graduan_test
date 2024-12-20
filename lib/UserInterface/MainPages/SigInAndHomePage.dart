import 'package:flutter/material.dart';
import 'package:graduan_test/ClassAndServices/ErrorHandler.dart';
import 'package:graduan_test/ClassAndServices/User/UserServices.dart';
import 'package:graduan_test/UserInterface/AUIComponents/SnackBars.dart';
import 'package:graduan_test/UserInterface/MainPages/HomePage.dart';
import 'package:graduan_test/UserInterface/UserPages/SignInPage.dart';
import 'package:provider/provider.dart';

class SignInAndHomePage extends StatelessWidget {
  const SignInAndHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInAndHomePageProvider(context: context),
      child: Scaffold(
        body:  Consumer<SignInAndHomePageProvider>(
            builder: (context, signInAndHomePageProvider, child) {
              if(authTokenGlobal != null){
                return Homepage(logOut: signInAndHomePageProvider._logOut,);
              }else{
                return SignInPage(loginSuccessfulChangePage: signInAndHomePageProvider._setSignInTrue);
              }
            }
        ),
      ),
    );
  }
}

class SignInAndHomePageProvider with ChangeNotifier{
  final BuildContext context;

  SignInAndHomePageProvider({
    required this.context,
});


  void _setSignInTrue(){
    notifyListeners();
  }

  Future<void> _logOut() async {

    ReturnHandler returnHandler = await  UserServices().logOutUser();

    if(returnHandler.success){
      SnackBarFunctions().showCustomSnackBar(context, returnHandler.text);
      authTokenGlobal = null;
      notifyListeners();
    }else{
      SnackBarFunctions().showCustomSnackBar(context, returnHandler.text);
    }

  }



}
