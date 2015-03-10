class Seller::ListingsController < ApplicationController
	before_action :authenticate_user!
	def new
		@listing = Listing.new
	end
end
