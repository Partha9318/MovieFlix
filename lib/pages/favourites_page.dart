import 'package:flutter/material.dart';
import 'package:movieflix/colors.dart';
import 'package:movieflix/pages/movie_info_page.dart';
import 'package:movieflix/services/database/favourites_database.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  FavouritesDB _favouritesDB = FavouritesDB.instance;
  List favouritesList = [];

  @override
  initState() {
    super.initState();

    getAllFavourites();
  }

  getAllFavourites() async {
    favouritesList = await _favouritesDB.getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.separated(
        itemCount: favouritesList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    print(
                      "name: ${favouritesList[index]['name']}, desc: ${favouritesList[index]['description']}, release_date: ${favouritesList[index]['release_date']}, rating: ${favouritesList[index]['rating']}, imageUrl: ${favouritesList[index]['image']}, voteCount: ${favouritesList[index]['vote_count']}, id: ${favouritesList[index]['id']}",
                    );
                    return MovieInfoPage(
                      name: favouritesList[index]['name'],
                      description: favouritesList[index]['description'],
                      releaseDate: favouritesList[index]['release_date'],
                      rating: favouritesList[index]['rating'],
                      imageUrl: favouritesList[index]['image'],
                      voteCount: favouritesList[index]['vote_count'],
                      id: favouritesList[index]['id'],
                    );
                  },
                ),
              );
            },
            child: ListTile(
              title: Text(
                favouritesList[index]['name'],
                style: TextStyle(color: textColor),
                overflow: TextOverflow.ellipsis,
              ),
              leading: Text(
                {(index + 1)}.toString(),
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
