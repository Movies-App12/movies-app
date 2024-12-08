import 'package:flutter/material.dart';
import 'package:movies/features/home/data/models/popular_models/movie.dart';
import 'package:movies/shared/app_theme/app_colors.dart';
import 'package:movies/shared/widgets/add.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/shared/widgets/loading_indicator.dart';
import 'package:intl/intl.dart';

class PopularItem extends StatelessWidget {
  final Movie movie;
  const PopularItem(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    TextStyle? titleLarge = Theme.of(context).textTheme.titleLarge;
    TextStyle? titleSmall = Theme.of(context).textTheme.titleSmall;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: height * 0.25,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}',
            height: MediaQuery.sizeOf(context).height * 0.25,
            width: double.infinity,
            fit: BoxFit.fill,
            placeholder: (context, url) => const LoadingIndicator(),
            errorWidget: (context, url, error) =>
                const Icon(Icons.image_not_supported),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.play_circle_filled,
            color: AppColors.white,
            size: 80,
          ),
        ),
        PositionedDirectional(
          top: height * 0.12,
          start: width * 0.02,
          child: SizedBox(
            height: height * 0.3,
            width: width * 0.3,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                  placeholder: (context, url) => const LoadingIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.image_not_supported),
                ),
                PositionedDirectional(
                  end: width * 0.18,
                  bottom: height * 0.24,
                  child: const Add(),
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          top: height * 0.255,
          start: width * 0.4,
          child: Text(
            movie.title,
            style: titleLarge,
          ),
        ),
        PositionedDirectional(
          top: height * 0.3,
          start: width * 0.4,
          child: Row(
            children: [
              Text(
                DateFormat('yyyy').format(
                  DateTime.parse(
                    movie.releaseDate,
                  ),
                ),
                style: titleSmall?.copyWith(fontSize: 10),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                movie.adult ? 'Pg-13' : 'R',
                style: titleSmall?.copyWith(fontSize: 10),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '2h 7m',
                style: titleSmall?.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
