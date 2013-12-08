{ stdenv, fetchurl, pkgconfig, intltool, python, pyrex, pygobject, pygtk
, notify, pythonDBus, bluez, gnome2, glib, gtk, libstartup_notification
, makeWrapper, xdg_utils, obex_data_server
, pulseaudio
}:

stdenv.mkDerivation rec {
  name = "blueman-1.23";

  src = fetchurl {
    url = "http://download.tuxfamily.org/blueman/${name}.tar.gz";
    sha256 = "04ghlh4h5bwp9mqr5jxcmjm01595l5fq5561qxvf369fvjy63cjh";
  };

  configureFlags = "--disable-polkit";

  buildInputs =
    [ pkgconfig intltool python pyrex pygobject pygtk notify pythonDBus
      bluez glib gtk libstartup_notification makeWrapper gnome2.gnome_python
    ];

  # !!! Ugly.
  PYTHONPATH = "${gnome2.gnome_python}/lib/${python.libPrefix}/site-packages/:${pygobject}/lib/${python.libPrefix}/site-packages/gtk-2.0:${pygtk}/lib/${python.libPrefix}/site-packages/gtk-2.0:${notify}/lib/${python.libPrefix}/site-packages/gtk-2.0";

  postInstall =
    ''
      # Create wrappers that set the environment correctly.
      for i in $out/bin/* $out/libexec/*; do
          wrapProgram $i \
              --prefix XDG_DATA_DIRS : ${gnome2.gnome_icon_theme}/share:$out/share \
              --set PYTHONPATH "$(toPythonPath $out):$PYTHONPATH" \
              --set LD_LIBRARY_PATH "${pulseaudio}/lib:" \
              --prefix PATH : ${xdg_utils}/bin
      done

      mkdir -p $out/nix-support
      echo ${obex_data_server} > $out/nix-support/propagated-user-env-packages
    ''; # */

  meta = {
    homepage = http://blueman-project.org/;
    description = "GTK+-based Bluetooth Manager";
  };
}
