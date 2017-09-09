# OmniAuth Zaif

This gem contains the Zaif OAuth2 Strategy for OmniAuth.

Supports the OAuth 2.0 Web Login. Read the Zaif developers docs for more details: https://corp.zaif.jp/api-docs/oauth/

## Using This Strategy

First start by adding this gem to your Gemfile:

```ruby
gem 'omniauth-zaif'
```

Next, tell OmniAuth about this provider. For a Rails app, your `config/initializers/omniauth.rb` file should look like this:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :zaif, "Client_ID", "Client_Secret"
end
```

## Authentication Hash

An example auth hash available in `request.env['omniauth.auth']`:

```ruby
{
  "provider" => "zaif",
  "uid" => "a123b4....",
    "info" => {
      "email" => "taro.yamada@example.com",
      "name" => "山田太郎",
      "kana" => "ヤマダタロウ",
      "certified" => true
    },
      "credentials" => {
        "token" => "a123b4...", # The OAuth 2.0 access token
        "refresh_token" => "a123b4...",
        "expires_at" => 1504994039,
        "expires" => true
      },
    "extra" => {}
}
```

## Licence

[MIT](https://github.com/nori3tsu/omniauth-zaif/blob/master/LICENSE)

## Author

[nori3tsu](https://github.com/nori3tsu)
