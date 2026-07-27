# 🌤️ Weather App

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![API](https://img.shields.io/badge/API-WeatherAPI-009688)](https://www.weatherapi.com/)

Красивое и функциональное мобильное приложение погоды на Flutter с поддержкой мультиязычности, автокомплитом городов и сохранением избранного.

---

## 📱 Скриншоты

<p align="center">
  <img src="docs/main.jpg" width="240" alt="Главный экран" />
  &nbsp;
  <img src="docs/search.jpg" width="240" alt="Поиск городов" />
  &nbsp;
  <img src="docs/forecast.jpg" width="240" alt="Прогноз погоды" />
  &nbsp;
  <img src="docs/forecast2.jpg" width="240" alt="Прогноз погоды, подробно" />
</p>

---

## ✨ Основные возможности

* **🔍 Умный поиск с автокомплитом:** Поиск городов на лету с подсказками через API-запросы к `WeatherAPI`.
* **📅 Детальный прогноз на 3 дня:** Почасовая детализация температуры, влажности, скорости и направления ветра, давления и осадков.
* **⭐ Избранные города:** Быстрый доступ к сохраненным локациям на главном экране с локальным сохранением состояния через `SharedPreferences`.
* **🌐 Мультиязычность (l10n):** Полная поддержка смены языков интерфейса.
* **🎨 Кастомный UI:** Продуманный адаптивный дизайн с аккуратной презентацией данных.

---

## 🛠️ Технологический стек

* **Framework:** Flutter
* **Language:** Dart
* **API:** [WeatherAPI](https://www.weatherapi.com/)
* **Local Storage:** `shared_preferences`
* **Localization:** `flutter_localizations` (`l10n`)
* **Networking:** HTTP / REST API

---

## 🚀 Быстрый запуск

1. **Клонируйте репозиторий:**
   ```bash
   git clone [https://github.com/твой_ник/weather_app.git](https://github.com/твой_ник/weather_app.git)
   cd weather_app
