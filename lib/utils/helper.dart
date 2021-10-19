import 'package:supabase/supabase.dart';

class MemFireHelper {
  static String anon = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImV4cCI6MzE3MjUyNzk4NywiaWF0IjoxNjM0NjA3OTg3LCJpc3MiOiJzdXBhYmFzZSJ9.vGuDA1IKSPptMxeeW33CUCebSbgw3Lu0E3aRJEbjxis';
  static String url = 'https://c5n26ni5g6h9180dths0.baseapi.memfiredb.com';
  static late SupabaseClient client;

  static String user = 'user';
  static String doc = 'doc';

  factory MemFireHelper() => MemFireHelper._();

  MemFireHelper._() {
    client = SupabaseClient(url, anon);
  }
}