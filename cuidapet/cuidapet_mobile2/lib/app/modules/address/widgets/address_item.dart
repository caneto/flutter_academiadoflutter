part of '../address_page.dart';

class _AddressItem extends StatelessWidget {
  final String address;
  final String additionalInfo;
  final VoidCallback onTap;

  const _AddressItem({
    required this.address,
    required this.additionalInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: onTap,
        title: Text(address),
        subtitle: Text(additionalInfo),
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
