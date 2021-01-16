module Services
  module Users
    class Validate
      attr_reader :email, :errors, :result

      def initialize(email)
        @email = email
        @errors  = []
        @result  = true
      end

      def process
        check_email
        @result = false if errors.present?
        render_result
      end

      private

      def render_result
        { result: result, object: email, errors: errors.flatten }
      end

      def check_email
        resp = Faraday.get('http://apilayer.net/api/check') do |req|
          req.params['access_key'] = ENV["API_LAYER_ACCESS_KEY"] || '90bb9c1e381d6969343824d8fbce8de5'
          req.params['email'] = email
        end

        if resp.status == 200
          body = JSON.parse(resp.body)

          unless body['format_valid'] == true && body['mx_found'] == true && 
             body['smtp_check'] == true && body['catch_all'] == false
            @result = false
          end
        else
          @errors << JSON.parse(resp.body)
        end
      end
    end
  end
end