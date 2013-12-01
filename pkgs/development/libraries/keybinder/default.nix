{ stdenv, fetchurl, python, pygtk, gtk2, gnome, autoconf, automake, libtool, pkgconfig}:

stdenv.mkDerivation rec {
  name = "keybinder-${version}";
  version = "0.3.0";
  namePrefix = "";

  buildInputs = with gnome; [python pygtk gtk2 gnome_common gtkdoc autoconf automake libtool pkgconfig];

  preConfigure = ''
    # Hack for gnome-autogen.sh - it doesn't support ACLOCAL_PATH
    for ac_path in $(echo $ACLOCAL_PATH | tr ':' ' '); do
        ACLOCAL_FLAGS+=" -I $ac_path"
    done
    export ACLOCAL_FLAGS
    ./autogen.sh
  '';

  src = fetchurl {
    url = "https://github.com/engla/keybinder/archive/v${version}.tar.gz";
    sha256 = "0kkplz5snycik5xknwq1s8rnmls3qsp32z09mdpmaacydcw7g3cf";
  };

  meta = {
    description = "A library for registering global keyboard shortcuts in GTK-based applications using the X Window System.";
    homepage = https://github.com/engla/keybinder;
    license = stdenv.lib.licenses.gpl2;
    maintainers = with stdenv.lib.maintainers; [ ktosiek ];
    platforms = stdenv.lib.platforms.linux;
  };
}

