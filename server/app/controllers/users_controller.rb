# class UsersController < ApplicationController

#   def create
#     @user = User.create(user_params)
#   end

#   def update
#     @user = User.find(params[:id])
#     if @user.update(user_params)
#       #send out some json?
#     else
#       #send out failure json?
#     end
#   end

#   def show
#     @user = User.find(params[:id])
#   end

#   private

#   def user_params
#     params.require(:user).permit(:name)
#   end
# end