class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    # if the user is saved successfully than respond with json data and status code 201
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  # Updating users
    def update
      user = User.find(params[:id])

      if user.update(user_params)
        render json: user, status: 200
      else
        render json: { errors: user.errors }, status: 422
      end
    end
    
    # Deleting users
      def destroy
        user = User.find(params[:id])
        user.destroy
        head 204
      end

private
  def user_params
   params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
