import "package:injectable/injectable.dart";
import "package:brillo/app/router/router.dart";
    
@lazySingleton
class RouterService {
  final BrilloRouter router = BrilloRouter();
}