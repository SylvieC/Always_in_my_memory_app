require 'spec_helper'

describe "CardsController" do

	 describe 'GET practice' do
	    

		   it "should render :practice template" do
		   get :practice
		   expect(response).to render_template("practice")
		 end
		end

		


   describe "POST create" do

	   	before(:each) do
	   		@card = mock_model("Card")
	   		allow(Card).to receive(:create)
	   	end

	   	it "should create a Card" do
	   		post :create, {card:{title: "DSL",content: "Domain Specific Language"}}
	   		expect(response).to redirect_to("/reserve")
	   	end

   end



end

