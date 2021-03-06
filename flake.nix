{
  description = ''Nim library for implementing JSON-RPC clients and servers'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."json_rpc-master".dir   = "master";
  inputs."json_rpc-master".owner = "nim-nix-pkgs";
  inputs."json_rpc-master".ref   = "master";
  inputs."json_rpc-master".repo  = "json_rpc";
  inputs."json_rpc-master".type  = "github";
  inputs."json_rpc-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."json_rpc-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}