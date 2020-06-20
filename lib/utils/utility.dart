class Utils {
  static T parse<T>(dynamic value) {
    String str = value == null ? "" : "$value";

    if (T == double) {
      return double.tryParse(str) ?? 0 as T;
    } else if (T == int) {
      return int.tryParse(str) ?? 0 as T;
    } else if (T == String) {
      return str as T;
    } else if (T == bool) {
      if (str == "true")
        return true as T;
      else
        return false as T;
    }

    return value;
  }
}

extension IntExtension on int {
  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000);
  }

  String toMmm() {
    switch (this) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      default:
        return "Dec";
    }
  }
}

extension DateTimeExtension on DateTime {
  String toDdMmYyyy() {
    if (this == null) return "";
    return "${this.day.toString().padLeft(2, "0")} - ${this.month.toString().padLeft(2, "0")} - ${this.year}";
  }

  String toDdMmmYyyy() {
    if (this == null) return "";
    return "${this.day.toString().padLeft(2, "0")} ${this.month.toMmm()} ${this.year}";
  }
}

extension ListExtension on List {
  bool isListEmpty() => this == null || this.isEmpty;

  bool isListNotEmpty() => !this.isListEmpty();
}
