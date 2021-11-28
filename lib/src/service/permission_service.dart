import 'dart:io';

import 'package:flutter_template/src/models/models.dart';
import 'package:permission_handler/permission_handler.dart';

mixin PermissionService {
  /// Android: Calendar
  /// iOS: Calendar (Events)
  static Future<void> requestCalendar() async {
    _osValidator();

    final result = await Permission.calendar.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'calendar-permission-not-granted', status: -1, message: 'Calendar Permission is not granted');
    }
  }

  /// Android: Camera
  /// iOS: Photos (Camera Roll and Camera)
  static Future<PermissionStatus> statusCamera() async {
    _osValidator();

    return Permission.camera.status;
  }

  /// Android: Camera
  /// iOS: Photos (Camera Roll and Camera)
  static Future<void> requestCamera() async {
    _osValidator();

    final result = await Permission.camera.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'camera-permission-not-granted', status: -1, message: 'Camera Permission is not granted');
    }
  }

  /// Android: Contacts
  /// iOS: AddressBook
  static Future<PermissionStatus> statusContacts() async {
    _osValidator();

    return Permission.contacts.status;
  }

  /// Android: Contacts
  /// iOS: AddressBook
  static Future<void> requestContacts() async {
    _osValidator();

    final result = await Permission.contacts.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'contacts-permission-not-granted', status: -1, message: 'Contacts Permission is not granted');
    }
  }

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation (Always and WhenInUse)
  static Future<PermissionStatus> statusLocation() async {
    _osValidator();

    return Permission.location.status;
  }

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation (Always and WhenInUse)
  static Future<void> requestLocation() async {
    _osValidator();

    final result = await Permission.location.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'location-permission-not-granted', status: -1, message: 'Location Permission is not granted');
    }
  }

  /// Android:
  ///   When running on Android < Q: Fine and Coarse Location
  ///   When running on Android Q and above: Background Location Permission
  /// iOS: CoreLocation - Always
  static Future<PermissionStatus> statusLocationAlways() async {
    _osValidator();

    return Permission.locationAlways.status;
  }

  ///   When running on Android Q and above: Background Location Permission
  /// iOS: CoreLocation - Always
  static Future<void> requestLocationAlways() async {
    _osValidator();

    final result = await Permission.locationAlways.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'location-always-permission-not-granted', status: -1, message: 'LocationAlways Permission is not granted');
    }
  }

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  static Future<PermissionStatus> statusLocationWhenInUse() async {
    _osValidator();

    return Permission.locationWhenInUse.status;
  }

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  static Future<void> requestLocationWhenInUse() async {
    _osValidator();

    final result = await Permission.locationWhenInUse.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(
          error: 'location-when-in-use-permission-not-granted', status: -1, message: 'LocationWhenInUse Permission is not granted');
    }
  }

  /// Android: None
  /// iOS: MPMediaLibrary
  static Future<PermissionStatus> statusMediaLibrary() async {
    _osValidator();

    return Permission.mediaLibrary.status;
  }

  /// Android: None
  /// iOS: MPMediaLibrary
  static Future<void> requestMediaLibrary() async {
    _osValidator();

    final result = await Permission.mediaLibrary.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'media-library-permission-not-granted', status: -1, message: 'MediaLibrary Permission is not granted');
    }
  }

  /// Android: Microphone
  /// iOS: Microphone
  static Future<PermissionStatus> statusMicrophone() async {
    _osValidator();

    return Permission.microphone.status;
  }

  /// Android: Microphone
  /// iOS: Microphone
  static Future<void> requestMicrophone() async {
    _osValidator();

    final result = await Permission.microphone.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'microphone-permission-not-granted', status: -1, message: 'Microphone Permission is not granted');
    }
  }

  /// Android: Phone
  /// iOS: Nothing
  static Future<PermissionStatus> statusPhone() async {
    _osValidator();

    return Permission.phone.status;
  }

  /// Android: Phone
  /// iOS: Nothing
  static Future<void> requestPhone() async {
    _osValidator();

    final result = await Permission.phone.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'phone-permission-not-granted', status: -1, message: 'Phone Permission is not granted');
    }
  }

  /// Android: Nothing
  /// iOS: Photos
  /// iOS 14+ read & write access level
  static Future<PermissionStatus> statusPhotos() async {
    _osValidator();

    return Permission.photos.status;
  }

  /// iOS: Photos
  /// iOS 14+ read & write access level
  static Future<void> requestPhotos() async {
    _osValidator();

    final result = await Permission.photos.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'photos-permission-not-granted', status: -1, message: 'Photos Permission is not granted');
    }
  }

  /// Android: Nothing
  /// iOS: Photos
  /// iOS 14+ read & write access level
  static Future<PermissionStatus> statusPhotosAddOnly() async {
    _osValidator();

    return Permission.photosAddOnly.status;
  }

  /// iOS: Photos
  /// iOS 14+ read & write access level
  static Future<void> requestPhotosAddOnly() async {
    _osValidator();

    final result = await Permission.photosAddOnly.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'photos-add-only-permission-not-granted', status: -1, message: 'PhotosAddOnly Permission is not granted');
    }
  }

  /// Android: Nothing
  /// iOS: Reminders
  static Future<PermissionStatus> statusReminders() async {
    _osValidator();

    return Permission.reminders.status;
  }

  /// Android: Nothing
  /// iOS: Reminders
  static Future<void> requestReminders() async {
    _osValidator();

    final result = await Permission.reminders.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'reminders-permission-not-granted', status: -1, message: 'Reminders Permission is not granted');
    }
  }

  /// Android: Body Sensors
  /// iOS: CoreMotion
  static Future<PermissionStatus> statusSensors() async {
    _osValidator();

    return Permission.sensors.status;
  }

  /// Android: Body Sensors
  /// iOS: CoreMotion
  static Future<void> requestSensors() async {
    _osValidator();

    final result = await Permission.sensors.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'sensors-permission-not-granted', status: -1, message: 'Sensors Permission is not granted');
    }
  }

  /// Android: Sms
  /// iOS: Nothing
  static Future<PermissionStatus> statusSms() async {
    _osValidator();

    return Permission.sms.status;
  }

  /// Android: Sms
  /// iOS: Nothing
  static Future<void> requestSms() async {
    _osValidator();

    final result = await Permission.sms.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'sms-permission-not-granted', status: -1, message: 'Sms Permission is not granted');
    }
  }

  /// Android: Microphone
  /// iOS: Speech
  static Future<PermissionStatus> statusSpeech() async {
    _osValidator();

    return Permission.speech.status;
  }

  /// Android: Microphone
  /// iOS: Speech
  static Future<void> requestSpeech() async {
    _osValidator();

    final result = await Permission.speech.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'speech-permission-not-granted', status: -1, message: 'Speech Permission is not granted');
    }
  }

  /// Android: External Storage
  /// iOS: Access to folders like `Documents` or `Downloads`. Implicitly
  /// granted.
  static Future<PermissionStatus> statusStorage() async {
    _osValidator();

    return Permission.storage.status;
  }

  /// iOS: Access to folders like `Documents` or `Downloads`. Implicitly
  /// granted.
  static Future<void> requestStorage() async {
    _osValidator();

    final result = await Permission.storage.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'storage-permission-not-granted', status: -1, message: 'Storage Permission is not granted');
    }
  }

  /// Android: Ignore Battery Optimizations
  static Future<PermissionStatus> statusIgnoreBatteryOptimizations() async {
    _osValidator();

    return Permission.ignoreBatteryOptimizations.status;
  }

  /// Android: Ignore Battery Optimizations
  static Future<void> requestIgnoreBatteryOptimizations() async {
    _osValidator();

    final result = await Permission.ignoreBatteryOptimizations.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(
          error: 'ignore-battery-optimizations-permission-not-granted', status: -1, message: 'IgnoreBatteryOptimizations Permission is not granted');
    }
  }

  /// Android: Notification
  /// iOS: Notification
  static Future<PermissionStatus> statusNotification() async {
    _osValidator();

    return Permission.notification.status;
  }

  /// Android: Notification
  /// iOS: Notification
  static Future<void> requestNotification() async {
    _osValidator();

    final result = await Permission.notification.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(error: 'notification-permission-not-granted', status: -1, message: 'Notification Permission is not granted');
    }
  }

  /// Android: Allows an application to access any geographic locations
  /// persisted in the user's shared collection.
  static Future<PermissionStatus> statusAccessMediaLocation() async {
    _osValidator();

    return Permission.accessMediaLocation.status;
  }

  /// Android: Allows an application to access any geographic locations
  /// persisted in the user's shared collection.
  static Future<void> requestAccessMediaLocation() async {
    _osValidator();

    final result = await Permission.accessMediaLocation.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(
          error: 'access-media-location-permission-not-granted', status: -1, message: 'AccessMediaLocation Permission is not granted');
    }
  }

  /// When running on Android Q and above: Activity Recognition
  /// When running on Android < Q: Nothing
  /// iOS: Nothing
  static Future<PermissionStatus> statusActivityRecognition() async {
    _osValidator();

    return Permission.activityRecognition.status;
  }

  /// When running on Android < Q: Nothing
  /// iOS: Nothing
  static Future<void> requestActivityRecognition() async {
    _osValidator();

    final result = await Permission.activityRecognition.request();
    if (result != PermissionStatus.granted) {
      throw CustomException.now(
          error: 'activity-recognition-permission-not-granted', status: -1, message: 'ActivityRecognition Permission is not granted');
    }
  }

  static void _osValidator() {
    if (!Platform.isAndroid && !Platform.isIOS) throw CustomException.now(error: 'unsupported-device', message: 'This platform is not supported');
  }
}
