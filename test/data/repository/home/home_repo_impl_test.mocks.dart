
import 'dart:async' as _i4;

import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart'
    as _i2;
import 'package:bevlioon/data/data_source/remote/services/home/home_service.dart'
    as _i3;
import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart'
    as _i6;
import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart'
    as _i7;
import 'package:bevlioon/data/models/response/popular_movies/popular_movies_response_model.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;


class _FakeNetworkResponse_0<T> extends _i1.SmartFake
    implements _i2.NetworkResponse<T> {
  _FakeNetworkResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class MockHomeService extends _i1.Mock implements _i3.HomeService {
  MockHomeService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.NetworkResponse<_i5.PopularMoviesResponseModel>>
      retrievePopularMovies(
              {required _i6.PaginationRequestModel? requestModel}) =>
          (super.noSuchMethod(
            Invocation.method(
              #retrievePopularMovies,
              [],
              {#requestModel: requestModel},
            ),
            returnValue: _i4.Future<
                    _i2.NetworkResponse<_i5.PopularMoviesResponseModel>>.value(
                _FakeNetworkResponse_0<_i5.PopularMoviesResponseModel>(
              this,
              Invocation.method(
                #retrievePopularMovies,
                [],
                {#requestModel: requestModel},
              ),
            )),
          ) as _i4.Future<_i2.NetworkResponse<_i5.PopularMoviesResponseModel>>);

  @override
  _i4.Future<_i2.NetworkResponse<_i7.MovieDetailsResponseModel>>
      retrieveMovieDetails({required int? movieId}) => (super.noSuchMethod(
            Invocation.method(
              #retrieveMovieDetails,
              [],
              {#movieId: movieId},
            ),
            returnValue: _i4.Future<
                    _i2.NetworkResponse<_i7.MovieDetailsResponseModel>>.value(
                _FakeNetworkResponse_0<_i7.MovieDetailsResponseModel>(
              this,
              Invocation.method(
                #retrieveMovieDetails,
                [],
                {#movieId: movieId},
              ),
            )),
          ) as _i4.Future<_i2.NetworkResponse<_i7.MovieDetailsResponseModel>>);
}

