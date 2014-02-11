require 'spec_helper'

describe "Cards"  do
 	describe "GET /practice"
 	it " should be successful" do
 		get :practice
 		response.should be_success
	 end
	



 it "should have the right title" do
   get 'practice'
   response.should have_tag( "h1", "The Practice Pile")
    
 end
end
