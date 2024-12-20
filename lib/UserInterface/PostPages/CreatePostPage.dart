import 'package:flutter/material.dart';
import 'package:graduan_test/ClassAndServices/Post/Post.dart';
import 'package:graduan_test/ClassAndServices/Post/PostServices.dart';
import 'package:graduan_test/UserInterface/AUIComponents/ReusableWidgets.dart';
import 'package:graduan_test/UserInterface/AUIComponents/SnackBars.dart';
import 'package:provider/provider.dart';


class CreatePostPage extends StatelessWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreatePostPageProvider( context: context),
      child: Scaffold(
        appBar: ReusableAppBarForText(title: "Create Post",
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          },
              icon: Icon(Icons.arrow_back_sharp, color: Colors.white,)
          ),
        ),
        body:  Consumer<CreatePostPageProvider>(
            builder: (context, createPostPageProvider, child) {
              return   Center(
                child: createPostPageProvider._isLoading ? ReusableLoadingIndicator() : Padding(
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
                        HeadingLarge(title: "Create Post"),
                        SizedBox(height: 20),

                        ReusableTextField(textEditingController: createPostPageProvider.titleTextTextEditingController, label: "Title", hintText: "title", maxLength: 400, maxLines: 1, errorText: createPostPageProvider.titleError,),
                        SizedBox(height: 20),
                        ReusableTextButton(text: "Create", onPressed: (){
                          createPostPageProvider._createPost(createPostPageProvider.titleTextTextEditingController.text);
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


class CreatePostPageProvider with ChangeNotifier {

  final BuildContext context;

  CreatePostPageProvider({
    required this.context,
});


  String? titleError;

  final TextEditingController titleTextTextEditingController = TextEditingController();


  bool _isLoading = false;

  Future<void> _createPost(String title) async {
    _isLoading = true;
    notifyListeners();

    titleError = null;
    if(title.trim().isEmpty){
      titleError = "Please enter a title";
    }else{

      ReturnPost? returnHandler = await PostServices().createPost(title:title);

      if(returnHandler == null){
        SnackBarFunctions().showCustomSnackBar(context, "Failed to create post: return value NULL");
      }else{
        if(returnHandler.success){
          titleTextTextEditingController.clear();
          SnackBarFunctions().showCustomSnackBar(context, returnHandler.text);
        }else{
          SnackBarFunctions().showCustomSnackBar(context, returnHandler.text);
        }
      }

    }



    _isLoading = false;
    notifyListeners();
  }


}

