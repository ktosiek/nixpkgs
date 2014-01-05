{ stdenv, pkgconfig, fetchurl, itstool, intltool, libxml2, glib, gtk3, pango, gdk_pixbuf, atk, pep8, python, makeWrapper, pygobject3, gobjectIntrospection }:

let
  version = "${major}.8";
  major = "0.3";
in

stdenv.mkDerivation rec {
  name = "d-feet-${version}";

  src = fetchurl {
    url = "http://download.gnome.org/sources/d-feet/${major}/d-feet-${version}.tar.xz";
    sha256 = "e8423feb18fdff9b1465bf8442b78994ba13c12f8fa3b08e6a2f05768b4feee5";
  };

  buildInputs = [
    pkgconfig libxml2 itstool intltool glib gtk3 pep8 python makeWrapper pygobject3
  ];

  gi_typelib_path = stdenv.lib.concatStringsSep ":" (
    map (pkg: "${pkg}/lib/girepository-1.0") [ gtk3 pango gdk_pixbuf atk gobjectIntrospection ]);

  postInstall =
    ''
      wrapProgram $out/bin/d-feet \
        --prefix PYTHONPATH : "$(toPythonPath $out):$(toPythonPath ${pygobject3})" \
        --prefix GI_TYPELIB_PATH : "${gi_typelib_path}"
    '';

  meta = {
    description = "D-Feet is an easy to use D-Bus debugger";

    longDescription = ''
      D-Feet can be used to inspect D-Bus interfaces of running programs
      and invoke methods on those interfaces.
    '';

    homepage = https://wiki.gnome.org/action/show/Apps/DFeet;
  };
}
