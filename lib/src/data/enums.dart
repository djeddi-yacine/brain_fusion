/// The [AIStyle] enum is used to specify the different styles that can be used
/// by the AI to generate the image. Each enum value corresponds to a specific
/// drawing style.
/// The available styles are:
/// - noStyle: No specific style is applied.
/// - anime: Anime-style drawing.
/// - moreDetails: Drawing with more details.
/// - cyberPunk: Cyberpunk-style drawing.
/// - kandinskyPainter: Kandinsky-style painting.
/// - aivazovskyPainter: Aivazovsky-style painting.
/// - malevichPainter: Malevich-style painting.
/// - picassoPainter: Picasso-style painting.
/// - goncharovaPainter: Goncharova-style painting.
/// - classicism: Classicism-style drawing.
/// - renaissance: Renaissance-style drawing.
/// - oilPainting: Oil painting-style drawing.
/// - pencilDrawing: Pencil drawing-style drawing.
/// - digitalPainting: Digital painting-style drawing.
/// - medievalStyle: Medieval-style drawing.
/// - render3D: 3D rendering-style drawing.
/// - cartoon: Cartoon-style drawing.
/// - studioPhoto: Studio photo-style drawing.
/// - portraitPhoto: Portrait photo-style drawing.
/// - khokhlomaPainter: Khokhloma-style painting.
/// - christmas: Christmas-style drawing.
enum AIStyle {
  /// Default value when no style is selected
  noStyle, // Default value when no style is selected
  /// Anime style
  anime, // Anime style
  /// Detailed style
  moreDetails, // Detailed style
  /// Cyberpunk style
  cyberPunk, // Cyberpunk style
  /// Kandinsky style
  kandinskyPainter, // Kandinsky style
  /// Aivazovsky style
  aivazovskyPainter, // Aivazovsky style
  /// Malevich style
  malevichPainter, // Malevich style
  /// Picasso style
  picassoPainter, // Picasso style
  /// Goncharova style
  goncharovaPainter, // Goncharova style
  /// Classicism style
  classicism, // Classicism style
  /// Renaissance style
  renaissance, // Renaissance style
  /// Oil painting style
  oilPainting, // Oil painting style
  /// Pencil drawing style
  pencilDrawing, // Pencil drawing style
  /// Digital painting style
  digitalPainting, // Digital painting style
  /// Medieval style
  medievalStyle, // Medieval style
  /// 3D rendering style
  render3D, // 3D rendering style
  /// Cartoon style
  cartoon, // Cartoon
  //Soviet cartoon
  sovietCartoon,
  /// Studio photo style
  studioPhoto, // Studio photo style
  /// Portrait photo style
  portraitPhoto, // Portrait photo style
  /// Khokhloma style
  khokhlomaPainter, // Khokhloma style
  /// Christmas style
  christmas, // Christmas style
}

/// The [Resolution] enum is used to specify the different resolutions that can be used
/// by the AI to generate the image. Each enum value corresponds to a specific
/// width and height.
/// The available resolutions are (width and height):
/// - 1024 x 1024.
/// - 1024 x 576.
/// - 576 x 1024.
/// - 1024 x 680.
/// - 680 x 1024.
enum Resolution {
  ///1024 x 1024
  r1x1,

  ///1024 x 576.
  r16x9,

  ///576 x 1024.
  r9x16,

  ///1024 x 680.
  r3x2,

  ///680 x 1024.
  r2x3
}
