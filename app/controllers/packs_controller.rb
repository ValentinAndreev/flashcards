class PacksController < ApplicationController
  before_action :set
  before_action :require_login
    
  def index
    @packs = current_user.packs.all    
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
  
  def add
    current_user.set_default(@pack.id) if @pack
    redirect_to packs_path, notice: t(:Pack_was_made_base) 
  end

  def remove
    @pack.base = false
    @pack.save
    redirect_to packs_path, notice: t(:Pack_was_removed_from_base)   
  end
    
  private
  
  def set
    @pack = current_user.packs.find(params[:id]) if params[:id]  
  end
  
  def pack_params
    params.require(:pack).permit(:title, :base)
  end 
end