require "rails_helper"

RSpec.describe "Articles", type: :request do
  before do
    @john = User.create!(email: "john@gmail.com", password: "password")
    @bob = User.create!(email: "bob@gmail.com", password: "password")
    @article = Article.create!(title: "Article one", body: "Article one body", user: @john)
  end
  
  describe "GET /articles/:id/edit" do
    context "none signed in user cannot edit article" do
      before { get "/articles/#{@article.id}/edit"}
      
      it "redirect to signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq(flash_message)
      end
    end
    
    context "Signed in user but not article owner cannot edit article" do
      before do
        login_as @bob
        get "/articles/#{@article.id}/edit"
      end
      
      it "Redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article"
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "Signed in user and article owner can update own article" do
      before do
        login_as @john
        get "/articles/#{@article.id}/edit"
      end
      
      it "Successfully edit article" do
        expect(response.status).to eq 200
      end
    end
    
  end
  
  describe "PUT /articles/:id" do
    context "none signed in user cannot update article" do
      before do
        put "/articles/#{@article.id}",
        params: {article: {title: "The Article", body: "The Body"}}
      end
      
      it "redirect to signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context 'with signed in users who are non-owners' do
      before do
        login_as(@bob)
        put "/articles/#{@article.id}",
                params: { article: {title: "New Title", body: "New body"} }
      end
      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "With signed in user who are owner" do
      before do
        login_as(@john)
        put "/articles/#{@article.id}",
                params: { article: {title: "New Title", body: "New body"} }
      end
      
      it "Successfully update article" do
        expect(response.status).to eq 302
      end
    end
    
  end
  
  
  
  describe "DELETE /articles/:id" do
    context "none signed in user cannot delete article" do
      before { delete "/articles/#{@article.id}"}
      
      it "redirect to signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "Signed in user but not article owner cannot delete article" do
      before do
        login_as @bob
        delete "/articles/#{@article.id}"
      end
      
      it "Redirect to home page" do
        expect(response.status).to eq 302
        flash_message = "You can only delete your own article"
        expect(flash[:alert]).to eq flash_message
      end
    end
    
    context "Signed in user and article owner can delete own article" do
      before do
        login_as @john
        delete "/articles/#{@article.id}"
      end
      
      it "Successfully delete article" do
        expect(response.status).to eq 302    
      end
    end
    
  end
  
  
  
  
  describe "GET /articles/:id" do
    context "With existing article" do
      before {get "/articles/#{@article.id}"} 
        
      it "handle existing article" do
        expect(response.status).to eq 200
      end
    end
    
    context "With non existing article" do
      before {get "/articles/xxx" }
      
      it "handle non existing article" do
        expect(response.status).to eq 302
        flash_message = "The article has not been found"
        expect(flash[:alert]).to eq(flash_message)
      end
    end
  end
  
end