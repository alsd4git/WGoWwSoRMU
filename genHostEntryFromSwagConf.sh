PROXY_FOLDER=~/docker_data/swag/nginx/proxy-confs #path where the swag/nginx config files are located
DOMAIN=.example.org #dns domain pointing to the machine to resolve
IP_TO_USE=192.168.0.1x #local ip of the machine while inside the vpn (assuming all services are on the same machine)
CONFIG_NAME=domains.txt #output filename

find $PROXY_FOLDER -type f -name '*.conf' -exec grep -H '^\s*server_name\s\+\([^;]\+\);' {} \; \
  | awk -v domain="$DOMAIN" -v ip="$IP_TO_USE" -F'server_name ' '{gsub(/\.\*;/, domain " " ip); print $2}' \
  | awk -v domain="$DOMAIN" -v ip="$IP_TO_USE" '{gsub(/\.\* /, domain " " ip "\n")}1' \
  | awk '{gsub(/_\;/, "")}1' \
  | awk 'BEGIN{RS=""; ORS="\n"} {gsub(/\n+/, "\n"); print}' > $CONFIG_NAME
