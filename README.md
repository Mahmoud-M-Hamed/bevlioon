# Bevlioon

A modern Flutter app to browse popular movies, view details, and save favorites offline.

## Setup

- Prerequisites
  - Flutter SDK installed
  - Android/iOS toolchains as needed
- Install dependencies
  - `flutter pub get`
- Run the app
  - `flutter run`
- Configuration is loaded from .env via `flutter_dotenv` in `core/di/dependency_injector.dart`.

## TMDB API Key (keep it out of source control)

- Environment variables (used by code):
  - `BASE_URL` → API base URL (e.g., `https://api.themoviedb.org/3`)
  - `ACCESS_TOKEN` → TMDB v4 Read Access Token (Bearer token)
  
- Create .env (local only) in project root:
  ```env
  BASE_URL=https://api.themoviedb.org/3
  ACCESS_TOKEN=YOUR_TMDB_V4_READ_TOKEN
  ```
- Do not commit .env
  - `.env` is already in `.gitignore`.

## Architecture (short)

- Layers
  - `core` (app init, DI, error abstraction)
  - `data` (network/local data sources, models, repo implementations)
  - `domain` (repository interfaces)
  - `presentation` (feature cubits + UI)
  - `utils` (Result, helpers, enums, logging)
  
- DI
  - GetIt service locator (`core/di`), modules registered in order (data_sources → repos → cubits).
  
- Networking
  - Dio wrapped by `ApiClient` returning `NetworkResponse<T>` (`isSuccess`, `httpStatusCode`, `data`, `message`).
  - `Authorization: Bearer ${dotenv.env['ACCESS_TOKEN']}` set in default headers.
  
- Result & error handling
  - `Result<T>` (Success/Failure) + `safe_async_call` to centralize try/catch with `AppErrorModel`.
  
- State management
  - Cubit/Bloc.

## Local storage for favorites

- Hive is used for offline favorites.
  - Box key: `my_fav_movies` (see `data/data_source/local/constants/hive_box_keys.dart`).
  - Model: `FavoriteMovieModel` (Hive type + adapter).
  - Service: `HiveDatabaseService` handles init/open; used at app init.
  - Repo: `FavoriteMovieHiveRepoImpl` ensures box is open, then add/remove/check/get.

## Run tests

- **Run all unit tests:**
  ```bash
  flutter test

- **Run (individual/specific file) unit tests:**
- ```bash
  flutter test test/*.dart

- Notes
  - Network tests mock `ApiClient` and never hit real endpoints.
  - Repo tests use `Result<NetworkResponse<T>>` with Mockito. If needed, register dummies in `setUpAll`.
  - Hive tests initialize a temporary Hive directory in tests.
