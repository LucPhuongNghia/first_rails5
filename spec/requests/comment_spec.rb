require "rails_helper"

RSpec.describe "comments", type: :request do
  before do
    @john = User.create!(email: "john@gmail.com", password: "password")
    @bob = User.create!(email: "bob@gmail.com", password: "password")
    @article = Article.create!(title: "Article one", body: "Article one body", user: @john)
  end
  
  describe "POST /articles/:id/comments" do
    context "User need to signed in to create comment" do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Body Comment"}}
      end
    
      it "Redirect to sign in page" do
        flash_message = "Please sign in or sign up first"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq(flash_message)
      end
    end
    
    context "Signed in user can create comment" do
      before do
        login_as @bob
        
        post "/articles/#{@article.id}/comments",
            params: { comment: {body: "Awesome blog."} }
      end
      
      it "Create the comment successfully" do
        flash_message = "Comment has been created"
        expect(response).to redirect_to(article_path(@article))
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq(flash_message)
      end
    end
  end
end