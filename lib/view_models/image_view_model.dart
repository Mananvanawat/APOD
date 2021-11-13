import 'package:apod/Models/image_error.dart';
import 'package:apod/Services/api_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../Models/image_model.dart';
import '../Services/image_service.dart';
import '../Services/date_service.dart';
class ImageViewModel extends ChangeNotifier{
   bool _loading = false;
   ImageModel? _imageModel;
   ImageError? _imageError;
   bool get loading => _loading;
   ImageModel? get imageModel => _imageModel;
   ImageError? get imageError => _imageError;
   ImageViewModel(){
     getImage(DateFormat('yyyy-MM-dd').format(DateTime.parse("2000-01-01")));
   }
   setLoading(bool loading) async {
     _loading = loading;
     notifyListeners();
   }
   setImageModel(ImageModel imageM){
     _imageModel = imageM;
     notifyListeners();
   }
   setImageError(ImageError imageError){
     _imageError = imageError;
     notifyListeners();
   }
   getImage(date)async{
     setLoading(true);
     var response = await ImageServices.getImage(date);
     print(response);
     if(response is Success){
       ImageError? imageError = ImageError(code: 200, message: "success" );
       setImageError(imageError);
       setImageModel(response.response as ImageModel);
     }
     if(response is Failure){
       ImageError? imageError = ImageError(code: response.code!, message: response.errorResponse.toString() );
       setImageError(imageError);
     }
     setLoading(false);
   }
}