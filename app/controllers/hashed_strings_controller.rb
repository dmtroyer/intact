class HashedStringsController < ApplicationController
  before_action :authenticate_user!

  # GET /
  def index
    @string = HashedString.new
    @strings = HashedString.where(user: current_user)
  end

  # POST /hashed_strings
  def create
    hashed_string = HashedString.new(hashed_string_params)
    hashed_string.user = current_user

    if hashed_string.save
      redirect_to root_path
    end
  end

  # DELETE /hashed_strings/:id
  def destroy
    hashed_string = HashedString.find(params[:id])
    hashed_string.destroy
    redirect_to root_path
  end

  private

  def hashed_string_params
    params.require(:hashed_string).permit(:original)
  end
end
