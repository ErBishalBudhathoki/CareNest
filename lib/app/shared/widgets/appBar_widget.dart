import 'dart:typed_data';

import 'package:carenest/app/shared/widgets/profile_placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:carenest/app/shared/widgets/profile_image_widget.dart';

class CustomAppBar extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final Uint8List? photoData;

  const CustomAppBar({
    Key? key,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.photoData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double toolbarHeight = MediaQuery.of(context).size.height * 0.1;
    const double avatarRadius = 30.0;
    const double endSpacing = 20.0;
    const double topSpacing = 5.0;

    return Container(
      color: Colors.white,
      child: AppBar(
        //toolbarHeight: toolbarHeight + MediaQuery.of(context).padding.top,
        toolbarHeight: 70.0,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        centerTitle: false,
        title: ProfilePlaceholder(
          firstName: firstName,
          lastName: lastName,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: endSpacing, top: topSpacing),
            child:
                // CircleAvatar(
                //   radius: avatarRadius,
                //   child: ClipOval(
                //     child: CircleAvatar(
                //       radius: avatarRadius,
                //       child: PhotoDisplayWidget(key: UniqueKey(), email: email),
                //     ),
                //   ),
                // ),
                CircleAvatar(
              child: ClipOval(
                child: CircleAvatar(
                  radius: 27.5,
                  child: CircleAvatar(
                    radius: 27.5,
                    child: ProfileImageWidget(photoData: photoData),
                    //     Container(
                    //   key: UniqueKey(),
                    //   width: 300,
                    //   height: 300,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     image: DecorationImage(
                    //       image: photoData != null
                    //           ? MemoryImage(photoData!)
                    //           : const AssetImage(
                    //                   'assets/icons/profile_placeholder.png')
                    //               as ImageProvider<Object>,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
