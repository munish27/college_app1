import 'dart:io';
import 'package:clg_app/data/entities/notification_entity.dart';
import 'package:flutter/foundation.dart';
import '../../../data/remote/api_response.dart';
import '../../../data/repository.dart';

class NotificationProvider extends ChangeNotifier {
  final Repository _repository = Repository();

  STATUS _status = STATUS.INITIAL;
  STATUS get status => _status;

  String? _errMsg;
  String? get errMsg => _errMsg;

  File? _filePath;
  File? get filePath => _filePath;

  List<NotificationEntity> _notifications = [];
  List<NotificationEntity> get notifications => _notifications;

  void getNotifications() async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;
      _notifications.clear();
      notifyListeners();
      final _results = await _repository.getNotifications();
      if (_results.status == STATUS.SUCCESS) {
        _notifications.addAll(_results.data!.data);
      } else {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
  }

  Future<bool> addNotifications({
    required String title,
    required String description,
  }) async {
    if (_status != STATUS.LOADING) {
      _status = STATUS.LOADING;

      notifyListeners();
      final _results = await _repository.uploadNotification(
        title: title,
        description: description,
        file: _filePath!,
      );
      if (_results.status == STATUS.ERROR) {
        _errMsg = _results.errMsg;
      }
      _status = _results.status;
      notifyListeners();
    }
    return _status == STATUS.SUCCESS ? true : false;
  }

  void addFile(File file) {
    _filePath = file;
    notifyListeners();
  }
}
