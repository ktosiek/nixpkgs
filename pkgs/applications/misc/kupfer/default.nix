{ stdenv, fetchurl, keybinder, python, gtk2, dbus_python, librsvg, dbus_tools, pygtk, pyxdg, gettext, intltool, perl, docutils, gnome_doc_utils, makeWrapper }:

stdenv.mkDerivation rec {
  # TODO: python modules:
  #  * wnck - allows Identify and focus running applications
  #  * keyring - allows Required by plugins that save passwords 
  #  * gnome - allows Log out cleanly with session managers *OTHER* than gnome-session >= 2.24
  #  * _sqlite3 - for firefox plugin
  #  * qrencode - for show_qrcode plugin
  name = "kupfer-${version}";
  version = "208";

  src = fetchurl {
    url = "https://github.com/downloads/engla/kupfer/kupfer-v${version}.tar.xz";
    sha256 = "014w50h5va3izi6wcq542i3x93m968gy36ln21cs54ab7vi8zpk5";
  };

  buildInputs = [ librsvg gtk2 keybinder python pygtk pyxdg gettext dbus_python dbus_tools perl intltool docutils gnome_doc_utils makeWrapper ];

  configurePhase = "python waf configure --prefix=$out";

  buildPhase = "python waf build";

  installPhase = "python waf install; ${postInstall}";

  preFixup = "rm $out/share/icons/hicolor/icon-theme.cache";

  postInstall = ''
    set -x
    for program in kupfer kupfer-exec; do
      wrapProgram "$out/bin/$program" \
        --prefix XDG_DATA_DIRS : "$out/share" \
        --set GDK_PIXBUF_MODULE_FILE "${librsvg}/lib/gdk-pixbuf/loaders.cache" \
        --prefix PYTHONPATH : $PYTHONPATH:${pygtk}/lib/${python.libPrefix}/site-packages/gtk-2.0:${pyxdg}/lib/${python.libPrefix}/site-packages/pyxdg:$out/lib/${python.libPrefix}/site-packages
    done
  '';

  meta = {
    description = "a convenient command and access tool";
    longDescription = ''
        Kupfer is an interface for quick and convenient access
      to applications and their documents.

        The most typical use is to find a specific application and launch it.
      It also provides plugins for communicators, music players, and more!
    '';
    homepage = http://engla.github.io/kupfer/;
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = [ stdenv.lib.maintainers.ktosiek ];
    platforms = stdenv.lib.platforms.linux;
  };
}
