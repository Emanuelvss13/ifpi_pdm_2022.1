import 'dart:io';

String fixture(String name) =>
    File('test/features/rick_and_morty/fixtures/$name').readAsStringSync();
