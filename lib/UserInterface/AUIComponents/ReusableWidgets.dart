import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduan_test/ClassAndServices/Post/Post.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final List<TextInputFormatter>? listTextInputFormatter;
  final bool obscureText;
  final String label;
  final String? hintText;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final int? maxLines;
  final Widget? suffixIcon;
  final String? errorText;

  const ReusableTextField({
    Key? key,
    required this.textEditingController,
    this.listTextInputFormatter,
    this.obscureText = false,
    required this.label,
    required this.hintText,
    this.onSubmitted,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.suffixIcon,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscuringCharacter: "•",
      controller: textEditingController,
      inputFormatters: listTextInputFormatter,
      obscureText: obscureText,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      maxLength: maxLength,
        maxLines:maxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: label,
        hintText: hintText,
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        errorText: errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
    );
  }
}


class PostTile extends StatelessWidget {
  final Post post;

  PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          title: Text(post.title),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Created: ${post.createdAt.toLocal()}',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'Updated: ${post.updatedAt.toLocal()}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Id: ${post.id}'),
            ],
          ),
          isThreeLine: true,
        ),
      ),
    );

  }
}

class LabelTextWidgetForColumn extends StatelessWidget {
  final String label;
  final String value;

  const LabelTextWidgetForColumn({
    Key? key,
    required this.label,
    required this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}

class HeadingLarge extends StatelessWidget {
  final String title;
  const HeadingLarge({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Text(
      title,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ReusableTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;

  ReusableTextButton({required this.text, required this.onPressed, this.buttonColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),

      child: Text(text,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
    );
  }
}

class ReusableAppBarForText extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actionButtons;
  final Color backgroundColor;
  final bool? centerTitle;
  final Widget? leading;
  const ReusableAppBarForText({
    Key? key,
    required this.title,
    this.actionButtons,
    this.backgroundColor = Colors.blue,
    this.centerTitle,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title == null ? null :  Text("$title", ),
      actions: actionButtons,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ReusableLoadingIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color indicatorColor;

  const ReusableLoadingIndicator({
    Key? key,
    this.size = 50.0,
    this.strokeWidth = 4.0,
    this.indicatorColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
