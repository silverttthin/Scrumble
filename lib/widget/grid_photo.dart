import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';


class GridPhoto extends StatefulWidget {
  List<AssetEntity> images;

  GridPhoto({
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  State<GridPhoto> createState() => _GridPhotoState();
}

class _GridPhotoState extends State<GridPhoto> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      //padding: EdgeInsets.all(10),
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemCount: widget.images.length,
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: AssetEntityImage(
            widget.images[i],
            isOriginal: false,
            fit: BoxFit.cover,
          ),
        );
      },
    );
    // return GridView(
    //   physics: const BouncingScrollPhysics(),
    //   gridDelegate:
    //   const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    //   children: widget.images.map((e) {
    //     return AssetEntityImage(
    //       e,
    //       isOriginal: false,
    //       fit: BoxFit.cover,
    //     );
    //   }).toList(),
    // );
  }
}