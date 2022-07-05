import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/description.dart';
import '../../utils/text.dart';

class Searched extends StatelessWidget {
  const Searched({Key? key, required this.searched}) : super(key: key);
  final List searched;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 10),
          Container(


              height: MediaQuery.of(context).size.height,
              child: ListView.builder(


                  scrollDirection: Axis.vertical,
                  itemCount: searched.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                  name: searched[index]['title'],
                                  bannerurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      searched[index]['backdrop_path'],
                                  posterurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      searched[index]['poster_path'],
                                  description: searched[index]['overview'],
                                  vote: searched[index]['vote_average']
                                      .toString(),
                                  launch_on: searched[index]
                                  ['release_date'],
                                )));
                      },
                      child:
                      searched[index]['title']!=null? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          searched[index]['poster_path']),
                                ),
                              ),
                              height: 100,
                              width: 50,

                            ),
                            SizedBox(height: 5),
                            Container(

                              child: modified_text(
                                  size: 17,color: Colors.white,
                                  text: searched[index]['title'] != null
                                      ? searched[index]['title']
                                      : 'Loading'),
                            )
                          ],
                        ),
                      ):Container(),

                    );
                  }))
        ],
      ),
    );
  }
}
