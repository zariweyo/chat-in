# Chat-In

Chat project made in Flutter and Firebase

## Use Hive

This app saves cache for Http Requests with hive. Hive needs to be generated his code using this command:

```
fvm flutter pub run build_runner build --delete-conflicting-outputs
```
It create the files XX.g.dart, which are the Adapters to use in the CacheRepository.

## Generate App Icon
To generate App Icon you need to change the icon in assets/icons/appIcon.png and then execute this command
```
fvm flutter pub run flutter_launcher_icons:main
```

It create tha files XX.g.dart, which are the Adapters to use in the CacheRepository.

