import 'package:flutter/material.dart';
import 'package:movieflix/colors.dart';
import 'package:movieflix/components/movie_tile.dart';

class HorizontalListViewer extends StatefulWidget {
  final List list;
  final String title;
  final Function onEndReached;
  const HorizontalListViewer({
    super.key,
    required this.list,
    required this.title,
    required this.onEndReached,
  });

  @override
  State<HorizontalListViewer> createState() => _HorizontalListViewerState();
}

class _HorizontalListViewerState extends State<HorizontalListViewer> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        widget.onEndReached();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: textColor,
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.list.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (index < widget.list.length) {
                return MovieTile(movie: widget.list[index]);
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: CircularProgressIndicator(color: subTextColor),
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
