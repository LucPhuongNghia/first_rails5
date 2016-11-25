class CommentsController < ApplicationController
  before_action :set_article
  
  def create
    @comment = @article.comments.build(comments_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment has been created"
    else
      flash.now[:alert] = "Comment has not been created"
    end
    redirect_to article_path(@article)
  end
  
  private
    def comments_params
      params.require(:comment).permit(:body)
    end
    
    def set_article
      @article = Article.find(params[:article_id])
    end
end
