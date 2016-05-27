require 'rails_helper'

RSpec.describe HashedStringsController, type: :controller do

  context "authenticated" do
    before :each do
      @user = create(:user_with_hashed_strings)
      sign_in @user
    end

    describe "GET #index" do
      before :each do
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end

      it "sets string and strings variables" do
        expect(assigns(:string)).to_not be_nil
        expect(assigns(:strings)).to_not be_nil
      end
    end

    describe "POST #create" do
      before :each do
        stub_iron_worker_calls
      end

      it "creates the hashed_string" do
        expect {
          post :create, { hashed_string: FactoryGirl.build(:hashed_string_without_user).attributes }
        }.to change(HashedString, :count).by(1)
      end

      it "assigns the current user to the hashed_string" do
        post :create, { hashed_string: FactoryGirl.build(:hashed_string_without_user).attributes }
        expect(HashedString.first.user).to eql(@user)
      end

      it "redirects to the main page" do
        post :create, { hashed_string: FactoryGirl.build(:hashed_string_without_user).attributes }
        expect_redirect_to(root_url)
      end
    end

    describe "DELETE #destroy" do
      before :each do
        stub_iron_worker_calls
        @string = create(:hashed_string, user: @user)
      end

      it "deletes the hashed_string" do
        expect {
          delete :destroy, id: @string.id
        }.to change(HashedString, :count).by(-1)
      end

      it "redirects to the main page" do
        delete :destroy, id: @string.id
        expect_redirect_to(root_url)
      end
    end
  end

  context "unauthenticated" do

    describe "GET #index" do
      it "redirects to sign in" do
        get :index
        expect_redirect_to(new_user_session_url)
      end
    end

    describe "POST #create" do
      it "redirects to sign in" do
        post :create
        expect_redirect_to(new_user_session_url)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to sign in" do
        delete :destroy, id: 1
        expect_redirect_to(new_user_session_url)
      end
    end

  end

end
