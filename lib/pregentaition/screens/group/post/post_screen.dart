import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/two_button_widget.dart';
import 'package:courtconnect/pregentaition/screens/group/post/widgets/comment_bottom_sheet.dart';
import 'package:courtconnect/pregentaition/screens/group/post/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Post',
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(AppRoutes.createPostScreen);
              },
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        spacing: 16.h,
        children: [
          TwoButtonWidget(
              buttons: const [
                'All Post',
                'My Post',
              ],
              selectedIndex: _selectedIndex,
              onTap: (index) {
                _selectedIndex = index;
                setState(() {});
              }),
          Expanded(
            child: _selectedIndex == 0
                ? ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return PostCardWidget(
                        profileImage: '',
                        profileName: 'Rakib',
                        description:
                            '"Hey everyone! 🏀 Whether you’re hitting the court for a pickup game or grinding in the gym, let’s keep pushing ourselves and each other to improve! Got any game tips or highlights to share? Let’s keep the energy high and the ball rolling!',
                        image: '',
                        time: '12h ago',
                        comments: '125',
                        onCommentsView: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const CommentBottomSheet();
                            },
                          );
                        },
                      );
                    })
                : ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return PostCardWidget(
                        isMyPost: true,
                        profileImage: '',
                        profileName: 'Rakib',
                        description:
                            '"Hey everyone! 🏀 Whether you’re hitting the court for a pickup game or grinding in the gym, let’s keep pushing ourselves and each other to improve! Got any game tips or highlights to share? Let’s keep the energy high and the ball rolling!',
                        image: '',
                        time: '12h ago',
                        comments: '125',
                        onCommentsView: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return  const CommentBottomSheet();
                            },
                          );
                        },
                      );
                    }),
          )
        ],
      ),
    );
  }
}
