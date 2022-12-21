class MolesController < ApplicationController
  before_action :set_mole, only: %i[ show edit update destroy ]
  
  def index
    @moles = Mole.all
  end

  def show
  end

  def new
    @mole = Mole.new
  end

  def create
    @mole = Mole.new(mole_params)
    @mole.user = current_user

    if @mole.save
      redirect_to mole_path(@mole), notice: "#{@mole.full_name} was added to your moles."
    else
      flash.now[:alert] = "Your new mole couldn't be added to your moles , please review any errors below."
      render :new
    end
  end

  def edit
  end

  def update
    if @mole.update(mole_params)
      redirect_to mole_path(@mole)
    else
      flash.now[:alert] = "#{@mole.full_name} couldn't be updated, please review any errors below."
      render :edit
    end
  end

  def destroy
    if @mole.destroy
      redirect_to moles_path, notice: "#{@mole.full_name} was removed from your moles."
    else
      redirect_to request.referer, alert: "#{@mole.full_name} couldn't be removed from your moles. (error: #{@mole.errors.full_messages.join(', ')})"
    end
  end

  private

  def mole_params
    params.require(:mole).permit(:first_name, :last_name, :dob, :weight, :length, :width, :height, :shade, :address)
  end

  def set_mole
    @mole = Mole.find(params[:id])
  end
end
