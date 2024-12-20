import 'package:flutter/material.dart';
import 'package:graduan_test/ClassAndServices/User/UserServices.dart';
import 'package:graduan_test/UserInterface/AUIComponents/ReusableWidgets.dart';
import 'package:graduan_test/UserInterface/AUIComponents/SnackBars.dart';
import 'package:provider/provider.dart';
import 'package:graduan_test/ClassAndServices/ErrorHandler.dart';

class UpdateUserInfoPage extends StatelessWidget {
  final String name;
  const UpdateUserInfoPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UpdateUserInfoPageProvider(name: name, context: context),
      child:Consumer<UpdateUserInfoPageProvider>(
          builder: (context, updateUserInfoPageProvider, child) {
          return Scaffold(
            appBar: ReusableAppBarForText(title: "Update User Info",
              leading: IconButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  icon: Icon(Icons.arrow_back_sharp, color: Colors.white,)
              ),
            ),
            body:  Center(
              child: updateUserInfoPageProvider._isLoading ? ReusableLoadingIndicator() : Padding(
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
                      HeadingLarge(title: "Update Name"),
                      SizedBox(height: 20),

                      ReusableTextField(textEditingController: updateUserInfoPageProvider.nameTextEditingController, label: "Name", hintText: "John", maxLength: 400, maxLines: 1, errorText: updateUserInfoPageProvider.nameError,),
                      SizedBox(height: 20),
                      ReusableTextButton(text: "Update", onPressed: (){
                        updateUserInfoPageProvider._updateName(updateUserInfoPageProvider.nameTextEditingController.text);
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class UpdateUserInfoPageProvider with ChangeNotifier{

  final String name;
  final BuildContext context;

  UpdateUserInfoPageProvider({
    required this.name,
    required this.context,
}){
    nameTextEditingController.text = name;
  }


  String? nameError;

  final TextEditingController nameTextEditingController = TextEditingController();


  bool _isLoading = false;

  Future<void> _updateName(String namePassed) async {
    _isLoading = true;
    notifyListeners();

    nameError = null;
    if(namePassed.trim().isEmpty){
      nameError = "Please enter a name";
    }else{
      ReturnHandler returnHandler = await UserServices().updateUserInfo(namePassed);

      if(returnHandler.success){
        SnackBarFunctions().showCustomSnackBar(context, returnHandler.text);
      }else{
        SnackBarFunctions().showCustomSnackBar(context, returnHandler.text);
      }
    }

    _isLoading = false;
    notifyListeners();
  }


}
