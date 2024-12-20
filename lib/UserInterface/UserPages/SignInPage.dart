import 'package:flutter/material.dart';
import 'package:graduan_test/ClassAndServices/AuthToken/AuthToken.dart';
import 'package:graduan_test/ClassAndServices/GeneralServices.dart';
import 'package:graduan_test/ClassAndServices/User/UserServices.dart';
import 'package:graduan_test/UserInterface/AUIComponents/ReusableWidgets.dart';
import 'package:graduan_test/UserInterface/AUIComponents/SnackBars.dart';
import 'package:provider/provider.dart';

String? authTokenGlobal;

class SignInPage extends StatelessWidget {
  final VoidCallback loginSuccessfulChangePage;

  const SignInPage({Key? key, required this.loginSuccessfulChangePage}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInPageProvider(loginSuccessfulChangePage: loginSuccessfulChangePage),
      child: Scaffold(
        body:  Consumer<SignInPageProvider>(
            builder: (context, signInPageProvider, child) {
            return   Center(
              child: signInPageProvider._isLoading ? ReusableLoadingIndicator() : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),

                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HeadingLarge(title: "Sign In"),
                      SizedBox(height: 20),

                      ReusableTextField(textEditingController: signInPageProvider.emailTextEditingController, label: "Email", hintText: "me@xmail.com", maxLength: 100, maxLines: 1, errorText: signInPageProvider.emailError,),
                      SizedBox(height: 10),
                      ReusableTextField(textEditingController:  signInPageProvider.passwordTextEditingController, label: "Password", hintText: "password", obscureText: true, maxLength: 100, maxLines: 1,errorText: signInPageProvider.passwordError),

                      SizedBox(height: 20),
                      ReusableTextButton(text: "Sign In", onPressed: (){
                        signInPageProvider.signIn(email: signInPageProvider.emailTextEditingController.text, password: signInPageProvider.passwordTextEditingController.text, context: context);
                      }),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }


}

class SignInPageProvider with ChangeNotifier {

  VoidCallback loginSuccessfulChangePage;

  SignInPageProvider({
   required this.loginSuccessfulChangePage
});

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  String? emailError;
  String? passwordError;

  bool _isLoading = false;

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    emailError = null;
    passwordError = null;
    notifyListeners();

    if (email.trim().isEmpty) {
      emailError = "Please enter an email";
      _isLoading = false;
      notifyListeners();
      return;
    }

    if (password.trim().isEmpty) {
      passwordError = "Please enter a password";
      _isLoading = false;
      notifyListeners();
      return;
    }

    if (!GeneralServices().isValidEmail(email)) {
      emailError = "Please enter a valid email";
      _isLoading = false;
      notifyListeners();
      return;
    }


      final returnAuthToken = await UserServices().loginUser(email: email, password: password,);

      if (returnAuthToken == null) {
        SnackBarFunctions().showCustomSnackBar(context, "Failed to log in. Please try again.",);
        _isLoading = false;
        notifyListeners();
        return;
      }

      if (returnAuthToken.success == false) {
        SnackBarFunctions().showCustomSnackBar(context, "Failed to log in. Please try again. ${returnAuthToken.text}",);
        _isLoading = false;
        notifyListeners();
        return;
      }

      AuthToken? authToken = returnAuthToken.authToken;
      if(authToken== null){
        SnackBarFunctions().showCustomSnackBar(context, "Failed to log in. Please try again. Token was null",);
        _isLoading = false;
        notifyListeners();
        return;
      }

        authTokenGlobal = authToken.token;
        print("this auth token: $authTokenGlobal }");

      SnackBarFunctions().showCustomSnackBar(context, "Login successful!",);
    loginSuccessfulChangePage();

    _isLoading = false;
    notifyListeners();
  }

}
