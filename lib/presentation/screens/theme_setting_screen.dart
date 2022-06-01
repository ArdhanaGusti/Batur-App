import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class ThemeSettingScreen extends StatefulWidget {
  const ThemeSettingScreen({Key? key}) : super(key: key);

  @override
  State<ThemeSettingScreen> createState() => _ThemeSettingScreenState();
}

class _ThemeSettingScreenState extends State<ThemeSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Setting"),
      ),
      body: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              ListTile(
                title: const Text('Light Mode'),
                leading: Radio<ThemeModeEnum>(
                  value: ThemeModeEnum.lightTheme,
                  groupValue: state.isDark,
                  onChanged: (value) => context.read<ThemeManagerBloc>().add(
                        const SaveThemeMode(
                          isDark: ThemeModeEnum.lightTheme,
                        ),
                      ),
                ),
              ),
              ListTile(
                title: const Text('Dark Mode'),
                leading: Radio<ThemeModeEnum>(
                  value: ThemeModeEnum.darkTheme,
                  groupValue: state.isDark,
                  onChanged: (value) => context.read<ThemeManagerBloc>().add(
                        const SaveThemeMode(
                          isDark: ThemeModeEnum.darkTheme,
                        ),
                      ),
                ),
              ),
              ListTile(
                title: const Text('System'),
                leading: Radio<ThemeModeEnum>(
                  value: ThemeModeEnum.systemTheme,
                  groupValue: state.isDark,
                  onChanged: (value) => context.read<ThemeManagerBloc>().add(
                        const SaveThemeMode(
                          isDark: ThemeModeEnum.systemTheme,
                        ),
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
