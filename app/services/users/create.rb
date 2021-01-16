module Services
  module Users
    class Create
      attr_reader :first_name, :last_name, :url, :email,
                    :user, :errors, :result

      def initialize(first_name, last_name, url, email)
        @first_name = first_name
        @last_name = last_name
        @url = url
        @email = email
        user = nil
        @errors  = []
        @result  = true
      end

      def process
        ActiveRecord::Base.transaction do
          save_user
          @result = false if errors.present?

          raise ActiveRecord::Rollback unless result
        end

        render_result
      end

      private

      def render_result
        { result: result, object: user, errors: errors.flatten }
      end

      def save_user
        @user = ::User.new(
          first_name: first_name,
          last_name: last_name,
          url: url,
          email: email
        )

        @user.save
        @errors << user&.errors&.messages unless user&.errors&.messages&.empty?
      end
    end
  end
end