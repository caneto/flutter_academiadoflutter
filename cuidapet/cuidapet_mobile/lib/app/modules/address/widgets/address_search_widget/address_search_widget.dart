part of '../../address_page.dart';

typedef AddressSelectedCallback = void Function(PlaceModel);

class _AddressSearchWidget extends StatefulWidget {
  final AddressSelectedCallback onAddressSelected;
  final PlaceModel? place;

  const _AddressSearchWidget({
    required this.onAddressSelected,
    this.place,
    super.key,
  });

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {
  final _controller = Modular.get<AddressSearchController>();
  final _searchTextEC = TextEditingController();
  final _searchTextFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.place != null) {
      _searchTextEC.text = widget.place?.address ?? '';
      _searchTextFocusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _searchTextEC.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  static const _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(style: BorderStyle.none),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: TypeAheadFormField<PlaceModel>(
        debounceDuration: const Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          controller: _searchTextEC,
          focusNode: _searchTextFocusNode,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.location_on),
            hintText: 'Busque um endereço',
            border: _border,
            disabledBorder: _border,
            enabledBorder: _border,
          ),
        ),
        itemBuilder: (_, item) => _ItemTile(address: item.address),
        onSuggestionSelected: _onSuggestionSelected,
        suggestionsCallback: _suggestionsCallback,
      ),
    );
  }

  Future<List<PlaceModel>> _suggestionsCallback(String pattern) async {
    if (pattern.isNotEmpty) {
      return _controller.searchAddress(pattern);
    }

    return const [];
  }

  void _onSuggestionSelected(PlaceModel suggestion) {
    _searchTextEC.text = suggestion.address;
    widget.onAddressSelected(suggestion);
  }
}

class _ItemTile extends StatelessWidget {
  final String address;

  const _ItemTile({required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}
