class StacksController < ApplicationController
	before_filter :signed_in_user, only: [:create, :new, :edit, :update]
end
