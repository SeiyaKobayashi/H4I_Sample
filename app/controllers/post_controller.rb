class PostController < ApplicationController
    before_action :authenticate_user
    before_action :if_admin, {only:[:index]}

    def if_admin
        if @current_user.id != 1
            flash[:notice] = "You can't view this page. Redirected to your personal page."
            redirect_to("/user/#{@current_user.id}")
        end
    end

    # Create a new post
    def new
        @post = Post.new(name: params[:name],
                         email: params[:email],
                         year: params[:year],
                         major: params[:major],
                         Q1: params[:Q1],
                         Q2: params[:Q2],
                         Q3: params[:Q3],
                         Q4: params[:Q4],
                         Q5: params[:Q5],
                         Q6: params[:Q6])
    end

    # This is called from "post/new.html.erb"
    def create
        @post = Post.new(name: params[:name],
                         email: params[:email],
                         year: params[:year],
                         major: params[:major],
                         Q1: params[:Q1],
                         Q2: params[:Q2],
                         Q3: params[:Q3],
                         Q4: params[:Q4],
                         Q5: params[:Q5],
                         Q6: params[:Q6],
                         user_id: @current_user.id)
        if @post.save
          flash[:notice] = "Your answer has been recorded."
          redirect_to("/user/#{@current_user.id}")
        else
          render("post/new")
        end
    end

    # Show all posts in descending order (new -> old)
    def index
        @posts = Post.all.order(updated_at: :desc)
        if @posts.empty?
          flash[:notice] = 'No answers available.'
        end
    end

    # Edit your post
    def edit
        @post = Post.find_by(id: params[:id])
    end

    # This is called from "post/edit.html.erb"
    def update
        @post = Post.find_by(id: params[:id])
        @post.name = params[:name]
        @post.email = params[:email]
        @post.year = params[:year]
        @post.major = params[:major]
        @post.Q1 = params[:Q1]
        @post.Q2 = params[:Q2]
        @post.Q3 = params[:Q3]
        @post.Q4 = params[:Q4]
        @post.Q5 = params[:Q5]
        @post.Q6 = params[:Q6]

        if @post.save
            flash[:notice] = "Your answer has been updated."
            redirect_to("/user/#{@current_user.id}")
        else
            render("post/edit")
        end
    end
end
