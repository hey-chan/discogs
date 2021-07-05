class BandsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_band, only: [:show, :destroy, :edit, :update]
  before_action :set_genres, only: [:new, :edit]
  #Takes one arugment by default, being the symbol set_band, meaning we do not need to invoke it in the show and destroy method
    
  def index 
      @bands = Band.all.includes(:genre)
  end 


  def show 
  end 
  
  def new 
      @band = Band.new
  end 

  def create
      @band = Band.new(band_params)
      if @band.save 
          redirect_to bands_path
      else 
          set_genres
          render "new"
      end 
  end 


  def destroy 
      @band.destroy
      redirect_to bands_path
    # We can use our route to create an id parameter
    # Need to make use of postman. Will result in 204 no content as we are not telling Rails anything after deleting
    # While we are repeating ourselves, there are instances where we can't avoid DRY principle
  end 


  def edit 
  end
      

  
  def update
     if  @band.update(band_params)
          redirect_to bands_path
     else 
          set_genres
          render "edit"
     end
  end 



  private 

  def band_params
      params.require(:band).permit(:name, :genre_id, :description)
  end

  def set_genres
      @genres = Genre.all 
  end 
  
  def set_band
      begin 
          @band = Band.find(params[:id])
      rescue
          render "not_found"
           # If raises an exception, this is caught by our rescue
      end 

  end 
end