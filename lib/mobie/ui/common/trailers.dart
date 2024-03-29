import 'package:flutter_review_movie/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_review_movie/inject.dart';
import 'package:flutter_review_movie/mobie/ui/common/my_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Trailers extends StatelessWidget {
  Trailers(this.id);

  final int id;

  void _launchURL(String key) async {
    final url = 'https://www.youtube.com/watch?v=$key';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final TrailerBloc bloc = Injection.injector.get<TrailerBloc>();
    bloc.movieId.add(id);

    _createThumbnail(Trailer trailer) => Container(
          padding: const EdgeInsets.only(right: 16.0),
          child: Material(
            elevation: 5.0,
            child: InkWell(
              onTap: () {
                _launchURL(trailer.key);
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CachedNetworkImage(imageUrl : getImageVideoUrl(trailer.key),
                      fit: BoxFit.fill, width: 200.0, height: 150.0),
                  Center(
                    child: Icon(Icons.play_circle_outline,
                        size: 50.0, color: Colors.grey[300]),
                  )
                ],
              ),
            ),
          ),
        );

    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text('Trailers', size: 18.0, isBold: true, color: Colors.white),
          Container(
              constraints: const BoxConstraints(maxHeight: 150.0),
              margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: StreamBuilder(
                stream: bloc.getTrailers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TrailerEntity>> snapshot) {
                  if (!snapshot.hasData || snapshot.hasError)
                    return Center(child: CircularProgressIndicator(),);
                  var trailers = snapshot.data;

                  return ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: trailers
                          .map((trailer) => _createThumbnail(trailer))
                          .toList());
                },
              ))
        ],
      ),
    );
  }
}
