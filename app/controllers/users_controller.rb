require './app/services/users/list'

class UsersController < ApplicationController
  def index
    if params[:first_name].present? && params[:last_name].present? && params[:url].present?
      result = ::Services::Users::List.new(
        params[:first_name],
        params[:last_name],
        params[:url]
      ).process

      @users = result[:object]
      @errors = result[:errors]
    else
      @users = User.all
    end
  end
end
