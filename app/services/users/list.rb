require 'uri'

module Services
  module Users
    class List
      attr_reader :first_name, :last_name, :url,
                    :user, :errors, :result, :emails

      def initialize(first_name, last_name, url)
        @first_name = first_name
        @last_name = last_name
        @url = url
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
        { result: result, object: User.all, errors: errors.flatten }
      end

      def valid_url?
        @url = URI.parse(@url).host
      rescue URI::InvalidURIError
        @errors << 'invalid url'
      end

      def generate_emails
        @emails = []
        @emails << "#{first_name}.#{last_name}@#{url}"
        @emails << "#{first_name}@#{url}"
        @emails << "#{first_name}#{last_name}@#{url}"
        @emails << "#{last_name}.#{first_name}@#{url}"
        @emails << "#{first_name.first}.#{last_name}@#{url}"
      end

      def check_emails
        @emails.each do |email|
          email_validate = ::Services::Users::Validate.new(email).process
          if email_validate[:errors].present?
            @errors.concat(email_validate[:errors])
          else
            save_email(email) if email_validate[:result]
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