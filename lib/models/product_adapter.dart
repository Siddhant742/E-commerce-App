import 'package:ecommerce_app/models/product.dart';
import 'package:hive/hive.dart';

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    return Product(
      id: reader.readString(),
      name: reader.readString(),
      category: reader.readString(),
      description: reader.readString(),
      price: reader.readDouble(),
      image: reader.readString(),
      quantity: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.category);
    writer.writeString(obj.description);
    writer.writeDouble(obj.price);
    writer.writeString(obj.image);
    writer.writeInt(obj.quantity);
  }
}
