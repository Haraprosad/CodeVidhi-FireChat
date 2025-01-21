import 'package:flutter/material.dart';
import 'package:codevidhi_firechat/core/utils/state_messages.dart';

Widget errorWidgetWithAction({required apiCallFailureModel}) {
  stopLoading();

  showErrorMessage(message: apiCallFailureModel.translatedMessage);

  return Center(child: Text(apiCallFailureModel.translatedMessage));
}
