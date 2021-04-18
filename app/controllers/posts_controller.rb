class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @posts = Post.all.order("created_at DESC")
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        @post.user_id = current_user.id

        respond_to do |format|
          if @post.save
            format.html { redirect_to root_path, notice: "Post was successfully created." }
            format.json { render :show, status: :created, location: @post }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
    
    end

    private

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
