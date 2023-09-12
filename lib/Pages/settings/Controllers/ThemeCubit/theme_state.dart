part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

final class ChangeThemeState extends ThemeState {
  final Color pickerColor;

  const ChangeThemeState({required this.pickerColor});
}

final class SaveThemeState extends ThemeState {
  final Color pickerColor;

  const SaveThemeState({
    required this.pickerColor,
  });
}
