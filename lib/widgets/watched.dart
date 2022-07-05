import 'package:flutter/material.dart';
import 'package:filmbox/utils/text.dart';

import '../pages/description.dart';


class WatchedMovies extends StatelessWidget {
  final List watched;
  const WatchedMovies({Key? key, required this.watched}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'Watched Movies',
            size: 26,
            color:Colors.white,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: watched.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                  name: watched[index]['title'],
                                  bannerurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      watched[index]['backdrop_path'],
                                  posterurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      watched[index]['poster_path'],
                                  description: watched[index]['overview'],
                                  vote: watched[index]['vote_average']
                                      .toString(),
                                  launch_on: watched[index]
                                  ['release_date'],
                                )));
                      },
                      child:
                      watched[index]['title']!=null? Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          watched[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: modified_text(
                                  size: 15,color: Colors.white,
                                  text: watched[index]['title'] ),
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
