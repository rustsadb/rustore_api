# Ruby client for Rustore API

## Client library for ruby apps

Rustore docs https://help.rustore.ru/rustore/for_developers/worki_with_RuStore_API

## Example usage:
You need company_id and the rsa key obtained from the RuStore console to initialize the client

```ruby
client = OpenWeather::Client.new(
  company_id: "123456",
  private_key: 'MIIEvQIBADANBgkqhkiG9...'
)
```

### Available methods
Method of obtaining an authorization token
```ruby
client.authorize!
```

Method of receiving a payment by its subscription_token
```ruby
client.payment_data(subscription_token)
```

Method of obtaining subscription data by payment ID
```ruby
client.subscription_by_invoice_id(invoice_id)
```

Method of obtaining subscription data by payment ID (V2)
```ruby
client.subscription_by_purchase_token(package_name, subscription_id, purchase_token)
```

Method of obtaining subscription status by payment ID
```ruby
client.subscription_state(invoice_id)
```

## Contributing
This is a demo version of the gem, you can participate in its development.
See [CONTRIBUTING](CONTRIBUTING.md).

