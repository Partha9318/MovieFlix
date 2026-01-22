import 'package:flutter/material.dart';
import 'package:movieflix/colors.dart';
import 'package:movieflix/services/database/favourites_database.dart';

class MovieInfoPage extends StatefulWidget {
  final String name;
  final String description;
  final String releaseDate;
  final double rating;
  final String imageUrl;
  final int voteCount;
  final int id;
  const MovieInfoPage({
    super.key,
    required this.name,
    required this.description,
    required this.releaseDate,
    required this.rating,
    required this.imageUrl,
    required this.voteCount,
    required this.id,
  });

  @override
  State<MovieInfoPage> createState() => _MovieInfoPageState();
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  final FavouritesDB _favouritesDB = FavouritesDB.instance;
  bool isFavourite = false;
  @override
  void initState() {
    checkFavouriteStatus();
    super.initState();
  }

  void checkFavouriteStatus() async {
    bool status = await _favouritesDB.isFavourite(widget.id);
    setState(() {
      isFavourite = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: BackButton(color: textColor),
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: 24,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageUrl,

              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Release Date: ${widget.releaseDate}',
                        style: TextStyle(color: subTextColor),
                      ),
                      IconButton(
                        onPressed: () {
                          isFavourite
                              ? _favouritesDB.removeFavourite(widget.id)
                              : _favouritesDB.addFavourite(
                                  id: widget.id,
                                  name: widget.name,
                                  releaseDate: widget.releaseDate,
                                  rating: widget.rating,
                                  voteCount: widget.voteCount,
                                  description: widget.description,
                                  image: widget.imageUrl,
                                );

                          setState(() {
                            isFavourite = !isFavourite;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFavourite
                                    ? 'Added to Favourites'
                                    : 'Removed from Favourites',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: isFavourite ? Colors.redAccent : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rating: ${widget.rating.toStringAsFixed(1)}/10 (${widget.voteCount})',
                    style: TextStyle(color: subTextColor),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
