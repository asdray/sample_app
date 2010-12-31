require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "failure" do
    
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end

    end # End failure

    describe "success" do

      # This test uses the CSS id of the input fields instead of the label.
      # This is best for consitency when there are fields that have not label.
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in :user_name,                  :with => "Example User"
          fill_in :user_email,                 :with => "user@example.com"
          fill_in :user_password,              :with => "foobar"
          fill_in :user_password_confirmation, :with => "foobar"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end # End success
    
  end # End signup
end # End Users