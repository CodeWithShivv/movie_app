import 'package:get_it/get_it.dart';
import 'package:movie_app/movies/data/datasource/movies_remote_data_source.dart';
import 'package:movie_app/movies/data/repository/movies_repository_impl.dart';
import 'package:movie_app/movies/domain/repository/movies_repository.dart';
import 'package:movie_app/movies/domain/usecases/get_all_popular_movies_usecase.dart';
import 'package:movie_app/movies/domain/usecases/get_all_top_rated_movies_usecase.dart';
import 'package:movie_app/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_app/movies/domain/usecases/get_movies_usecase.dart';
import 'package:movie_app/movies/presentation/controllers/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:movie_app/search/data/datasource/search_remote_data_source.dart';
import 'package:movie_app/search/data/repository/search_repository_impl.dart';
import 'package:movie_app/search/domain/repository/search_repository.dart';
import 'package:movie_app/search/domain/usecases/search_usecase.dart';
import 'package:movie_app/search/presentation/controllers/search_bloc/search_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_app/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import 'package:movie_app/watchlist/data/datasource/watchlist_local_data_source.dart';
import 'package:movie_app/watchlist/data/repository/watchlist_repository_impl.dart';
import 'package:movie_app/watchlist/domain/repository/watchlist_repository.dart';
import 'package:movie_app/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'package:movie_app/watchlist/domain/usecases/check_if_item_added_usecase.dart';
import 'package:movie_app/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import 'package:movie_app/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';
import 'package:movie_app/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    // Data source
    sl.registerLazySingleton<MoviesRemoteDataSource>(
        () => MoviesRemoteDataSourceImpl());

    sl.registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl());
    sl.registerLazySingleton<WatchlistLocalDataSource>(
        () => WatchlistLocalDataSourceImpl());

    // Repository
    sl.registerLazySingleton<MoviesRespository>(
        () => MoviesRepositoryImpl(sl()));
    sl.registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImpl(sl()));
    sl.registerLazySingleton<WatchlistRepository>(
        () => WatchListRepositoryImpl(sl()));

    // Use Cases
    sl.registerLazySingleton(() => GetMoviesDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetAllPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetAllTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => SearchUseCase(sl()));
    sl.registerLazySingleton(() => GetWatchlistItemsUseCase(sl()));
    sl.registerLazySingleton(() => AddWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => RemoveWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => CheckIfItemAddedUseCase(sl()));

    // Bloc
    sl.registerFactory(() => MoviesBloc(sl()));
    sl.registerFactory(() => MovieDetailsBloc(sl()));
    sl.registerFactory(() => PopularMoviesBloc(sl()));
    sl.registerFactory(() => TopRatedMoviesBloc(sl()));
    sl.registerFactory(() => SearchBloc(sl()));
    sl.registerFactory(() => WatchlistBloc(sl(), sl(), sl(), sl()));
  }
}
