set -e

# Do not run anything that shouldn't have secrets access after this line

[ -f secrets.bash ] && source secrets.bash
exec lein run
