import 'package:Hostinaar/main.dart';

class HostelsBrain{
  

  //Fetch hostels from supabase
  Future fetchHostels() async{
    final response = await supabase.from('hostels').select('*'); 

    print(response);
  }
  
}