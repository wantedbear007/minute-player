import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class FavouriteEvents {}

class FavouriteAdd extends FavouriteEvents {
  final String videoName;

  FavouriteAdd({required this.videoName});
}

class FavouriteDelete extends FavouriteEvents {
  final String videoName;

  FavouriteDelete({required this.videoName});
}

// State
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {
  final List<String> favouriteVideos;

  FavouriteInitial({required this.favouriteVideos});
}

// Global state Management
class FavouriteBloc extends Bloc<FavouriteEvents, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial(favouriteVideos: [])) {
    on<FavouriteAdd>(_addNewVideo);
    on<FavouriteDelete>(_deleteVideo);
  }

  void _addNewVideo(FavouriteAdd event, Emitter<FavouriteState> emit) {
    final List<String> updatedVideos =
        List.from((state as FavouriteInitial).favouriteVideos)
          ..add(event.videoName);

    emit(FavouriteInitial(favouriteVideos: updatedVideos));
  }

  void _deleteVideo(FavouriteDelete event, Emitter<FavouriteState> emit) {
    final List<String> updatedVideos =
        List.from((state as FavouriteInitial).favouriteVideos)
          ..remove(event.videoName);

    emit(FavouriteInitial(favouriteVideos: updatedVideos));
  }
}
