

class EmployeeSelectionModel {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final List<ClientModel> clients;
  final bool isSelected;
  final bool isLoadingClients;
  final bool hasLoadedClients;

  EmployeeSelectionModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.clients = const [],
    this.isSelected = false,
    this.isLoadingClients = false,
    this.hasLoadedClients = false,
  });

  EmployeeSelectionModel copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    List<ClientModel>? clients,
    bool? isSelected,
    bool? isLoadingClients,
    bool? hasLoadedClients,
  }) {
    return EmployeeSelectionModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      clients: clients ?? this.clients,
      isSelected: isSelected ?? this.isSelected,
      isLoadingClients: isLoadingClients ?? this.isLoadingClients,
      hasLoadedClients: hasLoadedClients ?? this.hasLoadedClients,
    );
  }
}

class ClientModel {
  final String id;
  final String email;
  final String name;
  final bool isSelected;

  ClientModel({
    required this.id,
    required this.email,
    required this.name,
    this.isSelected = false,
  });

  ClientModel copyWith({
    String? id,
    String? email,
    String? name,
    bool? isSelected,
  }) {
    return ClientModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
