import 'package:flutter/material.dart';
import 'package:movieflix/colors.dart';
import 'package:movieflix/pages/movie_info_page.dart';

class MovieTile extends StatelessWidget {
  final dynamic movie;
  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MovieInfoPage(
                name: movie['title'] ?? movie['name'] ?? 'No Title',
                description: movie['overview'] ?? 'No Description',
                releaseDate:
                    movie['release_date'] ??
                    movie['first_air_date'] ??
                    'No Date',
                rating: movie['vote_average'] ?? 0.0,
                imageUrl: movie['poster_path'] != null
                    ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                    : 'https://via.placeholder.com/150',
                voteCount: movie['vote_count'] ?? 0,
                id: movie['id'],
              );
            },
          ),
        );
      },
      child: Card(
        color: tileColor,
        child: Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: movie['poster_path'] != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}',

                        height: 210,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'lib/assets/images/placeholder.jpg',
                        height: 210,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 2.0,
                  left: 4.0,
                  right: 4.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'] ?? movie['name'] ?? 'No Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          movie['release_date'] ??
                              movie['first_air_date'] ??
                              'No Date',
                          style: TextStyle(color: subTextColor),
                        ),
                        Text(
                          '⭐${movie['vote_average'] != null ? movie['vote_average'].toStringAsFixed(1) : 'N/A'}',
                          style: TextStyle(color: subTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
