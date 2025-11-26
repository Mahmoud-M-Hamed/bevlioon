// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteMovieModelAdapter extends TypeAdapter<FavoriteMovieModel> {
  @override
  final int typeId = 1;

  @override
  FavoriteMovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteMovieModel(
      id: fields[0] as int?,
      title: fields[1] as String?,
      posterUrl: fields[2] as String?,
      alias: fields[3] as String?,
      releaseYear: fields[4] as String?,
      rating: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteMovieModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterUrl)
      ..writeByte(3)
      ..write(obj.alias)
      ..writeByte(4)
      ..write(obj.releaseYear)
      ..writeByte(5)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteMovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
