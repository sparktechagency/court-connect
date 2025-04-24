import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_network_image.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/group/post/controller/create_post_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/controller/post_edit_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/models/post_data.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key, required this.postData, required this.media,});

  final Map<String,dynamic> postData;
  final List<Media> media;

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {

  final EditPostController _controller = Get.put(EditPostController());
  final HomeController _homeController = Get.put(HomeController());


  final ImagePicker _picker = ImagePicker();

  late List<Media> _editableMedia;

  @override
  void initState() {
    super.initState();
    _editableMedia = List.from(widget.media);
    _controller.desController.text = widget.postData['des'];
  }
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Edit Post',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomListTile(
                image: _homeController.userImage.value,
                title: _homeController.userName.value,
                trailing: CustomButton(
                  height: 28.h,
                  radius: 8.r,
                  fontSize: 12.sp,
                  width: 89.w,
                  onPressed: () {
                    if (_controller.desController.text.trim().isEmpty) {
                      ToastMessageHelper.showToastMessage('Description is required.');
                      return;
                    } else {
                      //_controller.createPost(context, widget.userInfo['id']);
                      context.pop();
                    }
                  },

                  label: 'Post',
                ),
              ),


              ///<=========== description text form ==============>
              SizedBox(height: 16.h),
              CustomTextField(
                validator: (v) => null,
                filColor: Colors.white,
                borderColor: Colors.transparent,
                controller: _controller.desController,
                maxLine: 6,
                hintText: 'Write about your thought.......',
              ),


              if(_editableMedia.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 0.55,
                  enlargeCenterPage: true,
                  height: 240.h,
                ),
                items: _editableMedia.asMap().entries.map((entry) {
                  int index = entry.key;
                  Media image = entry.value;

                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        width: 200.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CustomNetworkImage(
                                imageUrl: '${ApiUrls.imageBaseUrl}${image.publicFileURL ?? ''}',
                              ),
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: GestureDetector(
                                  onTap: () => _removeExistingImage(index),
                                  child: Assets.icons.removePhoto.svg(
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: _editableMedia.isNotEmpty ? 20.h : 100.h),

              const Divider(
                thickness: 0.4,
              ),

              ///<===========  Photo  form ==============>

              CustomText(
                left: 10.w,
                fontsize: 10.sp,
                text: 'Upload photo (Optional)',
                bottom: 6.h,
                top: 10.h,
              ),

              GestureDetector(
                  onTap: _pickImage,
                  child: Assets.images.photoUpload
                      .image(height: 137.h, width: double.infinity)),
              SizedBox(height: 44.h),
            ],
          ),
        ),
      ),
    );
  }


  ///<=========== image Picker button ==============>

  Future<void> _pickImage() async {
    int totalImages = _editableMedia.length + _controller.images.length;

    if (totalImages >= 5) {
      ToastMessageHelper.showToastMessage('You can select up to 5 images only.');
      return;
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _controller.images.add(File(pickedFile.path));
      });
    }
  }



  void _removeExistingImage(int index) {
    setState(() {
      _editableMedia.removeAt(index);
    });
  }

}
