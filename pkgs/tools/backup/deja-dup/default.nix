{ stdenv, fetchurl, cmake, pkgconfig, vala, gettext, intltool, glib, gtk3, libnotify, gnome3, packagekit, libsecret, itstool, gobjectIntrospection }:

# TODO: bind to a specific duplicity

stdenv.mkDerivation {
  name = "deja-dup-34.1";
  src = fetchurl {
    url = "https://launchpad.net/deja-dup/34/34.1/+download/deja-dup-34.1.tar.xz";
    sha256 = "0lg5fyl3ixr9f0af2lamx7n5bicc9fw4jib66ky5qvnqqjk9lin5";
  };
  buildInputs = [ cmake pkgconfig vala gettext intltool glib gtk3 libnotify gnome3.libpeas packagekit libsecret itstool gobjectIntrospection ];
}
