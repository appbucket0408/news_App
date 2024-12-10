import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter_course/consts/styles.dart';

import '../services/uitls.dart';
import 'vertical_spacing.dart';

class ArticalWidget extends StatelessWidget {
  const ArticalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                    height: 60,
                    width: 60,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary),
              Container(
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.all(100.0),
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FancyShimmerImage(
                          height: size.height * 0.12,
                          width: size.height * 0.12,
                          boxFit: BoxFit.fill,
                          imageUrl: '',
                        ),
                      ), 
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          Text('title' , 
                          textAlign: TextAlign.justify,
                          maxLines: 2, 
                          overflow: TextOverflow.ellipsis,
                          style: smallTextStyle
                          
                          ), 
                        
                          const VerticalSpacing(5), 
                          Align(
                            alignment: Alignment.topRight,
                            child: Text('Reading Time',
                             maxLines: 1,  
                            style: smallTextStyle
                            )
                            
                            ), 
                            FittedBox(
                              child: Row(children: [
                                IconButton(onPressed: () {
                                  
                                },
                                icon:  const Icon(
                                  Icons.link, 
                                  color: Colors.blue, 
                                  )
                                ), 
                                Text('20-2-2020'*10, 
                                maxLines: 1,
                                style: smallTextStyle
                                )
                              ],),
                            )
                        ],),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
