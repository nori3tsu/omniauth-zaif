require 'net/http'
require 'uri'
require 'omniauth-oauth2'
require 'json'

module OmniAuth
  module Strategies
    class Zaif < OmniAuth::Strategies::OAuth2
      option :name, 'zaif'

      option :client_options, {
        site: 'https://zaif.jp',
        authorize_url: 'https://zaif.jp/oauth',
        token_url: 'https://oauth.zaif.jp/v1/token'
      }

      def authorize_params
        super.tap do |params|
          params[:scope] ||= 'id_info'
        end
      end

      uid { raw_info['id'] }

      info do
        {
          email: raw_info['email'],
          name: raw_info['name'],
          kana: raw_info['kana'],
          certified: raw_info['certified']
        }
      end

      def raw_info
        return @raw_info if @raw_info

        uri = URI.parse('https://api.zaif.jp/tapi')
        https = Net::HTTP.new(uri.host, uri.port)

        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.request_uri)

        req['token'] = access_token.token
        req.set_form_data({nonce: Time.now.to_i, method: 'get_id_info'})
        res = https.request(req)

        raise "failed to execute get_id_info. http status code: #{res.code}" unless res.code.to_i == 200

        res = JSON.load(res.body)
        raise "failed to execute get_id_info. error: #{res['error']}" unless res['success'] == 1

        @raw_info = res['return']['user']
      end
    end
  end
end
