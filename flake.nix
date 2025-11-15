{
    description = "Drawy - A simple brainstorming tool with an infinite canvas";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    };
    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in
    {
        packages.${system}.default = pkgs.stdenv.mkDerivation {
            pname = "drawy";
            version = "0.1.0";

            src = ./.;

            nativeBuildInputs = with pkgs; [
                cmake
                qt6.wrapQtAppsHook
            ];

            buildInputs = with pkgs; [
                qt6.qtbase
                qt6.qttools
            ];

            cmakeFlags = [
                "-DCMAKE_BUILD_TYPE=Release"
            ];

            meta = with pkgs.lib; {
                description = "A simple brainstorming tool with an infinite canvas";
                homepage = "https://github.com/prayag2/drawy";
                license = licenses.gpl3Plus;
                platforms = platforms.linux;
                maintainers = [ ];
            };
        };

        devShells.${system}.default = pkgs.mkShell {
            buildInputs = with pkgs; [
                qt6.full
                qtcreator
                cmake
                bear
                entr
            ];
            shellHook = ''
                which zsh >/dev/null && exec zsh
            '';
        };
    };
}
