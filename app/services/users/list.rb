require 'uri'
require './app/services/users/validate'
require './app/services/users/create'

module Services
  module Users
    class List
      attr_reader :first_name, :last_name, :url,
                    :user, :errors, :result, :emails

      def initialize(first_name, last_name, url)
        @first_name = first_name.downcase
        @last_name = last_name.downcase
        @url = url.downcase
        user = nil
        @emails  = []
        @errors  = []
        @result  = true
      end

      def process
        valid_url?
        generate_emails unless errors.present?
        check_emails unless errors.present?
        @result = false if errors.present?

        render_result
      end

      private

      def render_result
        { result: result, object: User.all, errors: errors.uniq }
      end

      def valid_url?
        unless @url.match(/\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i).present?
          @errors << 'invalid url'
        end

        @url = URI.parse(@url).path
      rescue URI::InvalidURIError
        @errors << 'invalid url'
      end

      def generate_emails
        @emails = []
        f_name = first_name.gsub(' ', '.')
        l_name = last_name.gsub(' ', '.')

        @emails << "#{f_name}.#{l_name}@#{url}"
        @emails << "#{f_name}@#{url}"
        @emails << "#{f_name}#{l_name}@#{url}"
        @emails << "#{l_name}.#{f_name}@#{url}"
        @emails << "#{f_name.first}.#{l_name}@#{url}"
      end

      def check_emails
        @emails.each do |email|
          email_validate = ::Services::Users::Validate.new(email).process
          if email_validate[:errors].present?
            @errors.concat(email_validate[:errors])
          elsif email_validate[:result]
            save_email(email)
            break
          end
        end
      end

      def save_email(email)
        email = ::Services::Users::Create.new(first_name, last_name, @url, email).process
        @errors.concat(email[:errors]) if email[:errors].present?
      end
    end
  end
end