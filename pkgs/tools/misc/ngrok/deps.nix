# This file was generated by go2nix.
{ stdenv, lib, fetchFromGitHub, fetchgit, fetchhg, fetchbzr }:

let
  goDeps = [
    {
      root = "bitbucket.org/kardianos/osext";
      src = fetchhg {
        url = "https://bitbucket.org/kardianos/osext";
        rev = "10";
        sha256 = "1sj9r5pm28l9sqx6354fwp032n53znx9k8495k3dfnyqjrkvlw6n";
      };
    }
    {
      root = "code.google.com/p/log4go";
      src = fetchhg {
        url = "https://code.google.com/p/log4go";
        rev = "48";
        sha256 = "0q906sxrmwir295virfibqvdzlaj340qh2r4ysx1ccjrjazc0q5p";
      };
    }
    {
      root = "github.com/gorilla/websocket";
      src = fetchFromGitHub {
        owner = "gorilla";
        repo = "websocket";
        rev = "f4076986b69612ecb8bc7ce06d742eda6286200d";
        sha256 = "09arvwlxw15maf4z8pcgjc25hd00mckqpdi0byafqfgm3nvvacvq";
      };
    }
    {
      root = "github.com/inconshreveable/go-update";
      src = fetchFromGitHub {
        owner = "inconshreveable";
        repo = "go-update";
        rev = "c1385108bc3a016f1c88b75ea7d2e2a356a1571d";
        sha256 = "16zaxa0i07ismxdmkvjj4dpyc9lgp6wa94q090m9a48si40w9sjn";
      };
    }
    {
      root = "github.com/inconshreveable/go-vhost";
      src = fetchFromGitHub {
        owner = "inconshreveable";
        repo = "go-vhost";
        rev = "c4c28117502e4bf00960c8282b2d1c51c865fe2c";
        sha256 = "1rway6sls6fl2s2jk20ajj36rrlzh9944ncc9pdd19kifix54z32";
      };
    }
    {
      root = "github.com/inconshreveable/mousetrap";
      src = fetchFromGitHub {
        owner = "inconshreveable";
        repo = "mousetrap";
        rev = "9dbb96d2c3a964935b0870b5abaea13c98b483aa";
        sha256 = "1f9g8vm18qv1rcb745a4iahql9vfrz0jni9mnzriab2wy1pfdl5b";
      };
    }
    {
      root = "github.com/inconshreveable/ngrok";
      src = fetchFromGitHub {
        owner = "inconshreveable";
        repo = "ngrok";
        rev = "b7d5571aa7f12ac304b8f8286b855cc64dd9bab8";
        sha256 = "0a5iq9l9f2xdg6gnc9pj0iczhycv1w5iwcqgzzap83xfpy01xkh4";
      };
    }
    {
      root = "github.com/influxdb/influxdb-go";
      src = fetchFromGitHub {
        owner = "influxdb";
        repo = "influxdb-go";
        rev = "63c9a5f67dcb633d05164bf8442160c9e2e402f7";
        sha256 = "16in1xhx94pir06aw166inn0hzpb7836xbws16laabs1p2np7bld";
      };
    }
    {
      root = "github.com/kr/binarydist";
      src = fetchFromGitHub {
        owner = "kr";
        repo = "binarydist";
        rev = "9955b0ab8708602d411341e55fffd7e0700f86bd";
        sha256 = "11wncbbbrdcxl5ff3h6w8vqfg4bxsf8709mh6vda0cv236flkyn3";
      };
    }
    {
      root = "github.com/nsf/termbox-go";
      src = fetchFromGitHub {
        owner = "nsf";
        repo = "termbox-go";
        rev = "9aecf65084a5754f12d27508fa2e6ed56851953b";
        sha256 = "16sak07bgvmax4zxfrd4jia1dgygk733xa8vk8cdx28z98awbfsh";
      };
    }
    {
      root = "github.com/rcrowley/go-metrics";
      src = fetchFromGitHub {
        owner = "rcrowley";
        repo = "go-metrics";
        rev = "f770e6f5e91a8770cecee02d5d3f7c00b023b4df";
        sha256 = "07dc74kiam8v5my7rhi3yxqrpnaapladhk8b3qbnrpjk3shvnx5f";
      };
    }
    {
      root = "github.com/stathat/go";
      src = fetchFromGitHub {
        owner = "stathat";
        repo = "go";
        rev = "01d012b9ee2ecc107cb28b6dd32d9019ed5c1d77";
        sha256 = "0mrn70wjfcs4rfkmga3hbfqmbjk33skcsc8pyqxp02bzpwdpc4bi";
      };
    }
    {
      root = "gopkg.in/check.v1";
      src = fetchgit {
        url = "https://github.com/go-check/check.git";
        rev = "871360013c92e1c715c2de6d06b54899468a8a2d";
        sha256 = "0i83qjmd4ri9mrfddhsbpj9nb43rf2j9803k030fj155j31klwcx";
      };
    }
    {
      root = "gopkg.in/yaml.v1";
      src = fetchgit {
        url = "https://github.com/go-yaml/yaml.git";
        rev = "b0c168ac0cf9493da1f9bb76c34b26ffef940b4a";
        sha256 = "0jbdy41pplf2d1j24qwr8gc5qsig6ai5ch8rwgvg72kq9q0901cy";
      };
    }
  ];

in

stdenv.mkDerivation rec {
  name = "go-deps";

  buildCommand =
    lib.concatStrings
      (map (dep: ''
              mkdir -p $out/src/`dirname ${dep.root}`
              ln -s ${dep.src} $out/src/${dep.root}
            '') goDeps);
}
