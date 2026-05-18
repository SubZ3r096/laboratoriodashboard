import 'package:flutter/foundation.dart';
import '../models/reservation.dart';
import '../services/mock_data_service.dart';

class ReservationsController extends ChangeNotifier {
  List<Reservation> _reservations = [];
  bool _isLoading = false;

  List<Reservation> get reservations => _reservations;
  bool get isLoading => _isLoading;

  void loadReservations() {
    _isLoading = true;
    notifyListeners();
    _reservations = List.from(MockDataService.reservations);
    _isLoading = false;
    notifyListeners();
  }

  void updateReservationStatus(String id, ReservationStatus status) {
    final index = _reservations.indexWhere((r) => r.id == id);
    if (index != -1) {
      _reservations[index] = Reservation(
        id: _reservations[index].id,
        customerName: _reservations[index].customerName,
        customerEmail: _reservations[index].customerEmail,
        customerPhone: _reservations[index].customerPhone,
        date: _reservations[index].date,
        time: _reservations[index].time,
        numberOfGuests: _reservations[index].numberOfGuests,
        tableNumber: _reservations[index].tableNumber,
        status: status,
        specialRequests: _reservations[index].specialRequests,
      );
      notifyListeners();
    }
  }
}
