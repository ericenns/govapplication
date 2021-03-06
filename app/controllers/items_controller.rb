class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      respond_to do |format|
        format.js
      end
    else
      # handle errors
    end
  end
  
  def update
    @item = current_user.items.find(params[:id])
    if @item.update_attributes(item_params)
      respond_to do |format|
        format.js
      end
    else
      # handle errors
    end
  end

  def destroy
    @item.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @item = current_user.items.find(params[:id])
    @action = t('edit') 
    
    respond_to do |format|
      format.js
    end
  end
  
  def search
    @search_item = params[:search][:search_text].mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').to_s.downcase
    @search_item.gsub! /\s+/, '%'

    @items = current_user.items.where("search LIKE ?", "%#{@search_item}%")
    respond_to do |format|
      format.js
    end
  end
  
  private

    def item_params
      params.require(:item).permit(:content, :title)
    end
    
    def correct_user
      @item = current_user.items.find_by(id: params[:id])
      redirect_to root_url if @item.nil?
    end
end
