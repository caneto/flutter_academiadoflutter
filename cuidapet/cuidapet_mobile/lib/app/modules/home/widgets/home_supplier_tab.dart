part of '../home_page.dart';

class _HomeSupplierTab extends StatelessWidget {
  final HomeController controller;

  const _HomeSupplierTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeTabHeader(controller: controller),
         Expanded(
          child: Observer(
            builder: (_) => AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: controller.suppliersPageType == SupplierPageType.list
                  ? _HomeSupplierList(controller: controller)
                  : _HomeSupplierGrid(controller: controller),
            ),
          ),
        ), 
      ],
    );
  }
}

class _HomeTabHeader extends StatelessWidget {
  final HomeController controller;

  const _HomeTabHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text('Estabelecimentos'),
          const Spacer(),
          Observer(
            builder: (_) => InkWell(
              onTap: () =>
                  controller.changeSupplierPageType(SupplierPageType.list),
              child: Icon(
                Icons.view_headline,
                color: controller.suppliersPageType == SupplierPageType.list
                    ? Colors.black
                    : Colors.grey,
              ),
            ),
          ),
          Observer(
            builder: (_) => InkWell(
              onTap: () =>
                  controller.changeSupplierPageType(SupplierPageType.grid),
              child: Icon(
                Icons.view_compact_sharp,
                color: controller.suppliersPageType == SupplierPageType.grid
                    ? Colors.black
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 class _HomeSupplierList extends StatelessWidget {
  final HomeController controller;

  const _HomeSupplierList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
         Observer(
           builder: (_) => SliverList(
             delegate: SliverChildBuilderDelegate(
               childCount: controller.suppliersByAddress.length,
               (_, index) => _HomeSupplierListItemWidget(
                 supplier: controller.suppliersByAddress[index],
               ),
             ),
           ),
         ),
      ],
    );
  }
} 

 class _HomeSupplierListItemWidget extends StatelessWidget {
  final SupplierNearbyMeModel supplier;

  const _HomeSupplierListItemWidget({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed('/supplier/', arguments: supplier.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              width: 1.sw,
              height: 80.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            supplier.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                '${supplier.distance.toStringAsFixed(2)} km',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: context.primaryColor,
                      radius: 15,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border.fromBorderSide(
                  BorderSide(color: Colors.transparent),
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(color: Colors.grey[100]!, width: 5),
                  ),
                  color: Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                    onError: (_, __) => const Nil(),
                    image: NetworkImage(supplier.logo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 

class _HomeSupplierGrid extends StatelessWidget {
  final HomeController controller;

  const _HomeSupplierGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        
         Observer(
          builder: (_) => SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (_, index) => _HomeSupplierCardItemWidget(
                supplier: controller.suppliersByAddress[index],
              ),
              childCount: controller.suppliersByAddress.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
            ),
          ),
        ), 
      ],
    );
  }
}

class _HomeSupplierCardItemWidget extends StatelessWidget {
  final SupplierNearbyMeModel supplier;

  const _HomeSupplierCardItemWidget({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed('/supplier/', arguments: supplier.id),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin:
                const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      supplier.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      '${supplier.distance.toStringAsFixed(2)} km',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
            ),
          ),
          Positioned(
            top: 4,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(supplier.logo),
              ),
            ),
          ), 
        ],
      ),
    );
  } 
} 
