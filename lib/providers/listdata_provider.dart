import 'package:flutter/foundation.dart';
import 'package:isolates_example/data_models.dart/hotels_list_model.dart';
import 'package:isolates_example/isolates_dir/isolate_file.dart';

class ListDataprovider with ChangeNotifier
{
  bool isLoading=false;

  HotelListModel hotels;

  Worker worker;

 Future<void> fetchList() async
  {
    print('hello');
    isLoading=true;
    
    if(worker==null)
   worker=Worker();

    await worker.isReady;

   hotels= await worker.sendMessageToNewIsolate();
   print(hotels.toString());
   isLoading=false;
   notifyListeners();
   //worker.dispose();
    
  }
}