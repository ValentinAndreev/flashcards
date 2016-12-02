class PacksController < ApplicationController
  before_action :set
  before_action :require_login
    
  def index
    @pack = current_user.packs.all    
  end
  
  def show
  end
  
  def new
    @pack = current_user.packs.new
  end
  
  def create
    @pack = current_user.packs.new(pack_params)
    if @pack.save    
      redirect_to packs_path
    else
      render 'new'
    end    
  end
  
  def edit 
  end
  
  def update   
    if @pack.update(pack_params)  
      redirect_to packs_path
    else
      render 'edit'
    end      
  end
  
  def destroy
    @pack.destroy    
    redirect_to packs_path   
  end

  private
  
  def set
    @pack = current_user.packs.find(params[:id]) if params[:id] && current_user  
  end
  
  def pack_params
    params.require(:pack).permit(:title)
  end 
end