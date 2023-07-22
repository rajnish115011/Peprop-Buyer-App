

import 'package:image_picker/image_picker.dart';

class Camera_Gallery_Class {



  Future<XFile?>open_camera() async {
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.camera);

  }
  Future<XFile?>open_gallery() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    return await _picker.pickImage(source: ImageSource.gallery);

  }

}