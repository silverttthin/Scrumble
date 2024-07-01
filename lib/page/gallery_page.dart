import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../Model/human_provider.dart';
import '../Model/scrum.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    final scrumData = Provider.of<List<Scrum>>(context);
    final humanData = Provider.of<HumanModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;



    return Scaffold(
      body: Container(
        child: MasonryGridView.count(
          // shrinkWrap: true,
          //padding: EdgeInsets.all(10),
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 10),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: scrumData.length,
          itemBuilder: (context, index) {
            Image image = new Image.network(scrumData[index].url);
            Completer<ui.Image> completer = new Completer<ui.Image>();
            image.image
                .resolve(new ImageConfiguration())
                .addListener(ImageStreamListener((ImageInfo info, bool _)=> completer.complete(info.image)));
            Future<PaletteGenerator>_updatePaletteGenerator ()async
            {
              PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
                Image.network(scrumData[index].url).image,
              );
              return paletteGenerator;
            }

            return InkWell(
              onTap: (){

              },
              // child: Container(
              //   width: double.maxFinite,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       boxShadow: [
              //         BoxShadow(
              //             color: Colors.black.withOpacity(0.2),
              //             offset: Offset(0, 5),
              //             blurRadius: 4)
              //       ]),
              //   child: ClipRRect(
              //     child: Image.network(humanData.imageList[index].url, fit: BoxFit.fill,),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              // ),
              child: FutureBuilder<PaletteGenerator>(
                future: _updatePaletteGenerator(),
                builder: (context, sshot) {
                  if(sshot.connectionState == ConnectionState.waiting) {
                    return Text('');
                  }
                  return FutureBuilder<ui.Image>(
                    future: completer.future,
                    builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                      if (snapshot.hasData) {
                        // return new Text(
                        //   '${snapshot.data?.width}x${snapshot.data?.height}'
                        // );
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(sshot.data!.dominantColor!.color.value).withOpacity(0.5)
                          ),
                          width: (screenWidth-35)/2,
                          height: (screenWidth-30)/2 * (snapshot.data!.height.toDouble()/snapshot.data!.width.toDouble()),
                          child: Center(
                            child: Container(
                              width: screenWidth/2*0.72,
                              height: screenWidth/2*(snapshot.data!.height.toDouble()/snapshot.data!.width.toDouble())*0.7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        offset: Offset(0, 5),
                                        blurRadius: 5)
                                  ]),
                              child: ClipRRect(
                                child: Image.network(scrumData[index].url, fit: BoxFit.fill,),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return new Text('');
                      }
                    },
                  );
                }
              ),
            );
          },
        ),
      ),
    );
  }

}
