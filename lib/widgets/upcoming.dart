import 'package:flutter/material.dart';

import '../pages/description.dart';
import '../utils/text.dart';
class UpcomingMovies extends StatelessWidget {
  final List upcoming;

  const UpcomingMovies({Key? key, required this.upcoming, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'Upcoming Movies',
            size: 26, color: Colors.white,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: upcoming.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                  name: upcoming[index]['title'],
                                  bannerurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      upcoming[index]['backdrop_path'],
                                  posterurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      upcoming
                                      [index]['poster_path'],
                                  description: upcoming
                                  [index]['overview'],
                                  vote: upcoming
                                  [index]['vote_average']
                                      .toString(),
                                  launch_on: upcoming
                                  [index]
                                  ['release_date'],
                                )));
                      },
                      child:
                      upcoming
                      [index]['title']!=null? Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          upcoming
                                          [index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: modified_text(
                                  size: 15,color: Colors.white,
                                  text: upcoming
                                  [index]['title']
                              ),
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

