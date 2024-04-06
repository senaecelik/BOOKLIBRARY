#!/bin/bash

 dart pub run easy_localization:generate -S "assets/translations" -O "lib/app/language"
 dart pub run easy_localization:generate -S "assets/translations" -O "lib/app/language" -o "locale_keys.g.dart" -f keys