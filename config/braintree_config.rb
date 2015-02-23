# Load keys for security purpose
SIN_CONF = YAML::load_file('config/keys.yml')[settings.environment.to_s]

# braintree creds
Braintree::Configuration.environment = SIN_CONF["bt_enviorenment"]
Braintree::Configuration.merchant_id = SIN_CONF["bt_merchant_id"]
Braintree::Configuration.public_key = SIN_CONF["bt_public_key"]
Braintree::Configuration.private_key = SIN_CONF["bt_private_key"]