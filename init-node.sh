source .env

counter=0
while true; do
  if [[ "$counter" -lt "${NUMS_OF_NODE}" ]]; then
    echo "Boostraping node${counter}..."
    rm -rf $(pwd)/storage/node${counter}
    docker run -v $(pwd)/storage/node${counter}:/genesis gaiad:local gaiad init node${counter} --home /genesis
    cp $(pwd)/storage/validator0/gaiad/config/genesis.json $(pwd)/storage/node${counter}/config
    persistent_peers=$(cat ./storage/validator0/gaiad/config/config.toml| grep 'persistent-peers ')
    sed -i -e "s/persistent-peers =.*/${persistent_peers}/g" $(pwd)/storage/node${counter}/config/config.toml
    sed -i -e "s/minimum-gas-prices =.*/minimum-gas-prices = \"${MIN_GAS_PRICE}\"/g" $(pwd)/storage/node${counter}/config/app.toml
    rm $(pwd)/storage/node${counter}/config/app.toml-e
    rm $(pwd)/storage/node${counter}/config/config.toml-e
  else
    break
  fi
  counter=$((counter+1))
done

docker system prune -f