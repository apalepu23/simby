class Seller::ListingsController < ApplicationController
	before_action :authenticate_user!
	def index
		@listings = Listing.all
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.create(listing_params)
	    # if @listing.save
	    #   render json: { message: "success", fileID: @listing.id }, :status => 200
	    # else
	    #   render json: { error: @listing.errors.full_messages.join(',')}, :status => 400
	    # end    
	    redirect_to seller_listing_path(@listing) 
	  
	end

	def show

	end

	private

	def listing_params
		params.require(:listing).permit(:category, :title, :description, :price, :sale_type, :photo)
	end

	helper_method :current_listing
	def current_listing
		@current_listing ||= Listing.find(params[:id])
	end
end