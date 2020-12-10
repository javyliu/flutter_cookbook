import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

typedef void OnPickImageCallback(double maxWidth, double maxHeight, int quality);

class ExImagePicker extends StatefulWidget {
  static String name = "拍照选图";

  @override
  _ExImagePickerState createState() => _ExImagePickerState();
}

class _ExImagePickerState extends State<ExImagePicker> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  bool isVideo = false;
  VideoPlayerController _videoCon;
  VideoPlayerController _toBeDisposed;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _playVideo(PickedFile file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      _videoCon = VideoPlayerController.file(File(file.path));
      await _videoCon.setVolume(1.0);
      await _videoCon.initialize();
      await _videoCon.setLooping(true);
      await _videoCon.play();
      setState(() {});
    }
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    if (_videoCon != null) {
      await _videoCon.setVolume(0.0);
    }
    if (isVideo) {
      final PickedFile file = await _picker.getVideo(source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else {
      await _displayPickImageDialog(context, (maxWidth, maxHeight, quality) async {
        try {
          final pickedFile = await _picker.getImage(source: source, maxHeight: maxHeight, maxWidth: maxWidth, imageQuality: quality);
          setState(() {
            _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  Future<void> _displayPickImageDialog(BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add optional parameters"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: maxWidthController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(hintText: "Enter maxWidth if desired"),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(hintText: "Enter maxHeight if desired"),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Enter quality if desired"),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(onPressed: () => Navigator.of(context).pop(), child: const Text("CANCEL")),
            FlatButton(
              onPressed: () {
                double width = maxWidthController.text.isNotEmpty ? double.parse(maxWidthController.text) : null;
                double height = maxHeightController.text.isNotEmpty ? double.parse(maxHeightController.text) : null;
                int quality = qualityController.text.isNotEmpty ? int.parse(qualityController.text) : null;
                onPick(width, height, quality);
                Navigator.of(context).pop();
              },
              child: const Text("PICK"),
            )
          ],
        );
      },
    );
  }

  @override
  void deactivate() {
    if (_videoCon != null) {
      _videoCon.setVolume(0.0);
      _videoCon.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ExImagePicker.name),
      ),
      body: Center(
        child: defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder(
                future: retrieveLostData(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text("you have not yet picked an image.", textAlign: TextAlign.center);
                    case ConnectionState.done:
                      return isVideo ? _previewVideo() : _previewImage();
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          "pick image/video error: ${snapshot.error}",
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          "you have not yet picked an image.",
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              )
            : (isVideo ? _previewVideo() : _previewImage()),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Semantics(
            label: "image_picker_example_from_gallery",
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'image0',
              tooltip: 'Pick Image from gallery',
              child: const Icon(Icons.photo_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image1',
              tooltip: 'Take a photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.gallery);
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: const Icon(Icons.video_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: const Icon(Icons.videocam),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed.dispose();
    }
    _toBeDisposed = _videoCon;
    _videoCon = null;
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewVideo() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_videoCon == null) {
      return const Text(
        "You have not yet picked a video",
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AspecRatioVideo(
        controller: _videoCon,
      ),
    );
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }

    if (_imageFile != null) {
      return Semantics(
        child: Image.file(File(_imageFile.path)),
        label: 'image_picker_example_picked_image',
      );
    } else if (_pickImageError != null) {
      return Text("pick image error: $_pickImageError", textAlign: TextAlign.center);
    } else {
      return const Text("You have not yet picked an image", textAlign: TextAlign.center);
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
  }
}

class AspecRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;

  const AspecRatioVideo({Key key, this.controller}) : super(key: key);
  @override
  _AspecRatioVideoState createState() => _AspecRatioVideoState();
}

class _AspecRatioVideoState extends State<AspecRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }

    if (initialized != controller.value.initialized) {
      initialized = controller.value.initialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value?.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    }

    return Container();
  }
}
