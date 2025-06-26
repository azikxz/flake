{
  socket,
  fifo,
  ...
}:

''
  (
      address: "${socket}",
      album_art: "auto",
      browser_song_sort: [Disc, Track, Artist, Title],
      cache_dir: None,
      enable_config_hot_reload: true,
      enable_mouse: true,
      max_fps: 60,
      on_song_change: None,
      password: None,
      scrolloff: 0,
      select_current_song_on_change: false,
      status_update_interval_ms: 1000,
      theme: "stylix",
      volume_step: 5,
      wrap_navigation: false,

      // tabs: [
      //   (
      //     name: "minimal",
      //     pane: Split(
      //       direction: Vertical,
      //       panes: [
      //         (
      //           size: "100%",
      //           borders: "ALL",
      //           pane: Split(
      //             borders: "ALL",
      //             direction: Horizontal,
      //             panes: [
      //               (
      //                 size: "40%",
      //                 borders: "RIGHT",
      //                 pane: Pane(AlbumArt),
      //               ),
      //               (
      //                 size: "60%",
      //                 pane: Pane(Queue),
      //               ),
      //             ],
      //           ),
      //         ),
      //         (
      //           size: "3",
      //           borders: "ALL",
      //           pane: Split(
      //             direction: Horizontal,
      //             panes: [
      //               (
      //                 pane: Pane(Property(
      //                   content: [
      //                     (kind: Property(Status(StateV2())))
      //                   ],
      //                   align: Left
      //                 )),
      //                 size: "10",
      //               ),
      //               (
      //                 size: "100%",
      //                 pane: Pane(ProgressBar),
      //               ),
      //               (
      //                 size: "25",
      //                 pane: Pane(Property(
      //                   content: [
      //                     (kind: Property(Status(Elapsed))),
      //                     (kind: Text(" / ")),
      //                     (kind: Property(Status(Duration))),
      //                     (kind: Group([
      //                       (kind: Text(" (")),
      //                       (kind: Property(Status(Bitrate))),
      //                       (kind: Text(" kbps)")),
      //                     ])),
      //                   ],
      //                   align: Right,
      //                 )),
      //               ),
      //             ]
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ]
      
      // cava: (
      //   autosens: true, // default true
      //   bar_symbols: ['▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'],
      //   framerate: 60, // default 60
      //   higher_cutoff_freq: 10000, // not passed to cava if not provided
      //   inverted_bar_symbols: ['▔', '🮂', '🮃', '▀', '🮄', '🮅', '🮆', '█'],
      //   lower_cutoff_freq: 50, // not passed to cava if not provided
      //   sensitivity: 100, // default 100
      //   
      //   input: (
      //     method: Fifo,
      //     source: "${fifo}",
      //     sample_rate: 44100,
      //     channels: 2,
      //     samble_bits: 16,
      //   ),
      //   
      //   smoothing: (
      //     noise_reduction: 77, // default 77
      //     monstercat: false, // default false
      //     waves: false, // default false
      //   ),
      // ),
  )
''
