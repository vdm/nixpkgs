{stdenv, fetchurl, unzip, raleway}:

let

  # TO UPDATE:
  # ./update.sh > ./fonts.nix
  # we use the extended version of raleway (same license).
  fonts = [raleway]
    ++ map fetchurl (builtins.filter (f: f.name != "raleway.zip") (import ./fonts.nix));

in
stdenv.mkDerivation rec {

  baseName = "league-of-moveable-type";
  version = "2016-10-15";
  name="${baseName}-${version}";

  srcs = fonts;

  buildInputs = [ unzip ];
  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp */*.otf $out/share/fonts/truetype
  '';

  meta = {
    description = "Font Collection by The League of Moveable Type";

    longDescription = '' We're done with the tired old fontstacks of
      yesteryear. The web is no longer limited, and now it's time to raise
      our standards. Since 2009, The League has given only the most
      well-made, free & open-source, @font-face ready fonts.
    '';

    homepage = "https://www.theleagueofmoveabletype.com/";

    license = stdenv.lib.licenses.ofl;

    platforms = stdenv.lib.platforms.all;
    maintainers = with stdenv.lib.maintainers; [ bergey profpatsch ];
  };
}
