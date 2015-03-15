class StaticPagesController < ApplicationController
	def index
		@listing = Listing.new
		@listings = Listing.all
	end
end
