require "rails_helper"

RSpec.describe "Articles", type: :request do
  before do
    @article = Article.create(title: "Article one", body: "Article one body")
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