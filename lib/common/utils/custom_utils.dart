class CustomUtils {
  static String formatDateDifference(DateTime date1, DateTime date2) {
    final difference =
        date2.difference(date1).abs(); // Différence absolue entre les dates

    if (difference.inDays >= 365) {
      // Si la différence est supérieure ou égale à 1 an
      final years = (difference.inDays / 365).floor();
      return '${years}y';
    } else if (difference.inDays >= 30) {
      // Si la différence est supérieure ou égale à 1 mois
      final months = (difference.inDays / 30).floor();
      return '${months}m';
    } else if (difference.inDays >= 7) {
      // Si la différence est supérieure ou égale à 1 semaine
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}sem';
    } else if (difference.inDays >= 1) {
      // Si la différence est supérieure ou égale à 1 jour
      return '${difference.inDays}d';
    } else if (difference.inHours >= 1) {
      // Si la différence est supérieure ou égale à 1 heure
      return '${difference.inHours}h';
    } else if (difference.inMinutes >= 1) {
      // Si la différence est supérieure ou égale à 1 minute
      return '${difference.inMinutes}min';
    } else {
      // Si la différence est inférieure à 1 minute
      return '${difference.inSeconds}s';
    }
  }
}
