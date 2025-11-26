
import 'dart:async' as _i3;

import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart'
    as _i5;
import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart'
    as _i7;
import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart'
    as _i9;
import 'package:bevlioon/data/models/response/popular_movies/popular_movies_response_model.dart'
    as _i6;
import 'package:bevlioon/domain/repository/home/base_home_repo.dart' as _i2;
import 'package:bevlioon/utils/helpers/result.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;


class MockBaseHomeRepo extends _i1.Mock implements _i2.BaseHomeRepo {
  MockBaseHomeRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Result<_i5.NetworkResponse<_i6.PopularMoviesResponseModel>>>
      retrievePopularMovies(
              {required _i7.PaginationRequestModel? requestModel}) =>
          (super.noSuchMethod(
            Invocation.method(
              #retrievePopularMovies,
              [],
              {#requestModel: requestModel},
            ),
            returnValue: _i3.Future<
                _i4.Result<
                    _i5.NetworkResponse<
                        _i6.PopularMoviesResponseModel>>>.value(_i8.dummyValue<
                _i4
                .Result<_i5.NetworkResponse<_i6.PopularMoviesResponseModel>>>(
              this,
              Invocation.method(
                #retrievePopularMovies,
                [],
                {#requestModel: requestModel},
              ),
            )),
          ) as _i3.Future<
              _i4.Result<_i5.NetworkResponse<_i6.PopularMoviesResponseModel>>>);

  @override
  _i3.Future<_i4.Result<_i5.NetworkResponse<_i9.MovieDetailsResponseModel>>>
      retrieveMovieDetails({required int? movieId}) => (super.noSuchMethod(
            Invocation.method(
              #retrieveMovieDetails,
              [],
              {#movieId: movieId},
            ),
            returnValue: _i3.Future<
                _i4.Result<
                    _i5.NetworkResponse<
                        _i9.MovieDetailsResponseModel>>>.value(_i8.dummyValue<
                _i4.Result<_i5.NetworkResponse<_i9.MovieDetailsResponseModel>>>(
              this,
              Invocation.method(
                #retrieveMovieDetails,
                [],
                {#movieId: movieId},
              ),
            )),
          ) as _i3.Future<
              _i4.Result<_i5.NetworkResponse<_i9.MovieDetailsResponseModel>>>);
}

