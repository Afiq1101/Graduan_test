import 'package:flutter/material.dart';
import 'package:graduan_test/ClassAndServices/Post/Post.dart';
import 'package:graduan_test/ClassAndServices/Post/PostServices.dart';
import 'package:graduan_test/UserInterface/AUIComponents/ReusableWidgets.dart';
import 'package:graduan_test/UserInterface/AUIComponents/SnackBars.dart';
import 'package:provider/provider.dart';

class ViewAllPostsPage extends StatelessWidget {
  const ViewAllPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  ChangeNotifierProvider(
      create: (context) => ViewAllPostsPageProvider(context: context),
      child: Consumer<ViewAllPostsPageProvider>(
          builder: (context, viewAllPostsPageProvider, child) {
          return Scaffold(
              appBar: ReusableAppBarForText(
                  title: "View Posts",
                leading: IconButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                    icon: Icon(Icons.arrow_back_sharp, color: Colors.white,)
                ),
              ),
              body: viewAllPostsPageProvider._isLaoding ? ReusableLoadingIndicator() :

              viewAllPostsPageProvider._listOfPosts.isEmpty ?  SizedBox(
                height: size.height,
                width: size.width,
                child: Center(
                  child: Text("No Posts Were Found"),
                ),
              ):
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {

                        return PostTile(post: viewAllPostsPageProvider._listOfPosts[index]);

                      },
                      childCount: viewAllPostsPageProvider._listOfPosts.length,
                    ),
                  ),
                ],
              ),
          );
        }
      ),
    );
  }
}


class ViewAllPostsPageProvider with ChangeNotifier {
  final BuildContext context;
  ViewAllPostsPageProvider({
    required this.context,
}){
    _doAll();
}

  Future<void> _doAll() async {
    _listOfPosts.clear();
    _isLaoding = true;
    notifyListeners();

    await _getPosts();

    _isLaoding = false;
    notifyListeners();
  }

Future<void> _getPosts() async {

  ReturnListOfPosts? returnListOfPosts = await PostServices().getPosts();

  if(returnListOfPosts == null){
    SnackBarFunctions().showCustomSnackBar(context, "Failed to get posts: Return Value Null");
  }else{
    if(returnListOfPosts.success){
      List<Post>? posts = returnListOfPosts.posts;

      if(posts != null){
        _listOfPosts.addAll(posts);
      }else{
        SnackBarFunctions().showCustomSnackBar(context, "Failed to get posts: Return Value Null");
      }
    }else{
      SnackBarFunctions().showCustomSnackBar(context, returnListOfPosts.text);
    }
  }


  notifyListeners();
}


final List<Post> _listOfPosts = [];
bool _isLaoding = false;


}



