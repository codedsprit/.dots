set shell := ["zsh", "-c"]

_default:
    @just -l

alias g := gens
alias f := format
alias c := clean
alias r := rebuild
alias u := flake-update

# List all generations
gens:
    @echo "🏠🏠🏠 Listing home-manager generations 🏠🏠🏠"
    @home-manager --list-generations

# Cleans up garbage
clean:
    @echo "Cleaning up unused Nix store items"
    @nix-collect-garbage -d

# Format all files
format:
    @nixfmt $(find ./ -type f -name '*.nix')
    @stylua -f $(find . -type f -name '.stylua.toml') $(find . -type f  -name '*.lua')

# Update flake git revision
flake-update:
    @echo "Syncing latest git rev"
    @nix flake update

# Rebuild configuration
[linux]
rebuild:
    @echo "🏠🏠🏠 Rebuilding home-manager configuration 🏠🏠🏠 "
    @nix run home-manager -- switch --flake .#pop
