import 'package:app_abelhas/core/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';

class ProfilePhotoWidget extends StatefulWidget {
  // final ProfileModel? profile;
  const ProfilePhotoWidget({
    super.key,
  });

  @override
  State<ProfilePhotoWidget> createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<ProfilePhotoWidget> {
  @override
  Widget build(BuildContext context) {
    // var cubit = context.read<ProfileCubit>();
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
          height: displayHeight(context) * 0.10,
          width: displayHeight(context) * 0.10,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              ClipOval(
                  child: Container(
                      color: Colors.grey,
                      child: Image.network(
                        'https://img.freepik.com/vetores-gratis/circulo-azul-com-usuario-branco_78370-4707.jpg',
                        fit: BoxFit.fill,
                        errorBuilder: (context, url, error) => _nameInitials(),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CircularProgressIndicator();
                          // return Shimmer.fromColors(
                          //   baseColor: Colors.grey.shade400,
                          //   highlightColor: Colors.grey,
                          //   child: Container(color: Colors.grey),
                          // );
                        },
                      ))),
              Positioned(
                  bottom: 0,
                  right: -30,
                  child: RawMaterialButton(
                    onPressed: () {
                      // showModal(
                      //   title: 'Trocar Foto',
                      //   showCloseButton: true,
                      //   modalContent: TrocarFotoModal(
                      //     imageCropper: getIt.get<ImageCropper>(),
                      //   ),
                      // );
                    },
                    elevation: 2.0,
                    fillColor: Color(0xFFF5F6F9),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 14,
                    ),
                    padding: EdgeInsets.all(8.0),
                    shape: CircleBorder(),
                  )),
            ],
          )),
    );
  }

  Widget _nameInitials() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          '',
          style: const TextStyle(color: Colors.white, fontSize: 32),
        ),
      ),
    );
  }
}
