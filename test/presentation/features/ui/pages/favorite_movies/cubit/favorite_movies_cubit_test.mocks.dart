
import 'dart:async' as _i3;

import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart'
    as _i4;
import 'package:bevlioon/domain/repository/favorite_movie_hive/movie_hive_repo.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;


class MockBaseFavoriteMovieHiveRepo extends _i1.Mock
    implements _i2.BaseFavoriteMovieHiveRepo {
  MockBaseFavoriteMovieHiveRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.FavoriteMovieModel>> getFavoriteMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavoriteMovies,
          [],
        ),
        returnValue: _i3.Future<List<_i4.FavoriteMovieModel>>.value(
            <_i4.FavoriteMovieModel>[]),
      ) as _i3.Future<List<_i4.FavoriteMovieModel>>);

  @override
  _i3.Future<void> addFavorite(_i4.FavoriteMovieModel? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #addFavorite,
          [movie],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> removeFavorite(int? movieId) => (super.noSuchMethod(
        Invocation.method(
          #removeFavorite,
          [movieId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<bool> isFavorite(int? movieId) => (super.noSuchMethod(
        Invocation.method(
          #isFavorite,
          [movieId],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<void> ensureBoxIsOpen() => (super.noSuchMethod(
        Invocation.method(
          #ensureBoxIsOpen,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

