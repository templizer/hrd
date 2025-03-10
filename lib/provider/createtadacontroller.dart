
import 'package:cnattendance/repositories/tadarepository.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class CreateTadaController extends GetxController {
  var fileList = <PlatformFile>[].obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final expensesController = TextEditingController();

  TadaRepository repository = TadaRepository();

  final key = GlobalKey<FormState>();

  void onFileClicked() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    final platformFile = result?.files.single;
    if (platformFile != null) {
      fileList.add(platformFile);
    }
  }

  void checkForm() {
    if (key.currentState!.validate()) {
      if (fileList.isEmpty) {
        showToast("Attachment is required");
        return;
      }
      createTada();
    }
  }

  Future<String> createTada() async {
    EasyLoading.show(status: translate('loader.loading'),maskType: EasyLoadingMaskType.black);

    final response = await repository.createTada(titleController.text, descriptionController.text, expensesController.text, fileList);
    debugPrint(response.toString());
    EasyLoading.dismiss(animation: true);

    if (response.statusCode == 200) {
      showToast("Tada has been submitted");
      Get.back();
      return "Loaded";
    } else {
      var errorMessage = response.message;
      print(errorMessage);
      throw errorMessage;
    }
  }

  void removeItem(int index) {
    fileList.removeAt(index);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
