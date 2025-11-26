import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/movie_response_model.dart';
import 'package:bevlioon/presentation/features/ui/shared/movie_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieAdapter', () {
    test('should create from MovieSummaryResponseModel with all fields', () {
      final summaryModel = const MovieSummaryResponseModel(
        id: 1,
        title: 'Test Movie',
        posterPath: '/test.jpg',
        releaseYear: '2023-01-01',
        rating: 8.5,
      );

      final adapter = MovieAdapter.fromSummary(movie: summaryModel);

      expect(adapter.id, 1);
      expect(adapter.title, 'Test Movie');
      expect(adapter.posterPath, '/test.jpg');
      expect(adapter.releaseYear, '2023');
      expect(adapter.rating, 8.5);
      expect(adapter.overview, null);
    });

    test('should create from MovieDetailsResponseModel with all fields', () {
      final detailsModel = const MovieDetailsResponseModel(
        title: 'Detailed Movie',
        posterPath: '/detailed.jpg',
        releaseYear: '2023',
        rating: 9.0,
        overview: 'Detailed overview',
      );

      final adapter = MovieAdapter.fromDetails(movie: detailsModel, id: 2);

      expect(adapter.id, 2);
      expect(adapter.title, 'Detailed Movie');
      expect(adapter.posterPath, '/detailed.jpg');
      expect(adapter.releaseYear, '2023');
      expect(adapter.rating, 9.0);
      expect(adapter.overview, 'Detailed overview');
    });

    test('should handle null or empty values gracefully', () {
      final summaryModel = const MovieSummaryResponseModel(
        id: 3,
        title: 'Minimal Movie',
        posterPath: null,
        releaseYear: null,
        rating: null,
      );

      final adapter = MovieAdapter.fromSummary(movie: summaryModel);

      expect(adapter.id, 3);
      expect(adapter.title, 'Minimal Movie');
      expect(adapter.posterPath, null);
      expect(adapter.releaseYear, null);
      expect(adapter.rating, null);
      expect(adapter.overview, null);
    });

    test('should handle different date formats correctly', () {
      var summaryModel = const MovieSummaryResponseModel(
        id: 4,
        title: 'Date Test',
        posterPath: null,
        releaseYear: '2023-05-15',
        rating: null,
      );
      var adapter = MovieAdapter.fromSummary(movie: summaryModel);
      expect(adapter.releaseYear, '2023');
      
      summaryModel = const MovieSummaryResponseModel(
        id: 5,
        title: 'Year Test',
        posterPath: null,
        releaseYear: '2024',
        rating: null,
      );
      adapter = MovieAdapter.fromSummary(movie: summaryModel);
      expect(adapter.releaseYear, '2024');
      
      summaryModel = const MovieSummaryResponseModel(
        id: 6,
        title: 'Null Test',
        posterPath: null,
        releaseYear: null,
        rating: null,
      );
      adapter = MovieAdapter.fromSummary(movie: summaryModel);
      expect(adapter.releaseYear, null);
    });
  });
}

