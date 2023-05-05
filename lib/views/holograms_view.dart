import 'package:exam_app/models/hologram.dart';
import 'package:exam_app/viewmodels/holograms_view_model.dart';
import 'package:exam_app/views/hologram_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// View for holograms
class HologramsView extends StatelessWidget {
  const HologramsView({super.key});

  // override build method
  @override
  Widget build(BuildContext context) {
    /// Get holograms from provider
    List<Hologram> holograms = context.watch<HologramsViewModel>().holograms;

    return Column(
      children: [
        const Text("Hologrammer"),
        Expanded(
          child: ListView.builder(
              itemCount: holograms.length,
              itemBuilder: (context, index) {
                Hologram hologram = holograms[index];
                return Card(
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HologramView(hologram: hologram))),
                    child: ListTile(
                      leading: hologram.icon != null
                          ? Icon(hologram.icon)
                          : hologram.image!,
                      title: Text(hologram.title),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
