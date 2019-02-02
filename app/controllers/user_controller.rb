class UserController < ApplicationController
    before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}

    # Show user's details
    def show
        @user = User.find_by(id: params[:id])
    end

    ### Create a new user ###
    def new
        @user = User.new
    end

    def create
        @user = User.new(
            name: params[:name],
            email: params[:email],
            password: params[:password],
            password_confirmation: params[:password_confirmation],
            image_name: "default_user.png"
        )
        if @user.save
            # Browser keeps track of session id
            session[:user_id] = @user.id
            flash[:notice] = "Signed up successfully."
            redirect_to("/user/#{@user.id}")
        else
            flash[:notice] = "Invalid fields. Please read signup instructions carefully and try again."
            @name = params[:name]
            @email = params[:email]
            redirect_to("/signup")
        end
    end

    ### Login ###
    def login_form
    end

    def login
        email = params[:email]
        password = params[:password]
        search_key = generate_hash(email, password)
        @user = User.find_by(search_key: search_key)
        if @user
          # Browser keeps track of session id
          session[:user_id] = @user.id
          flash[:notice] = "Logged in successfully."
          redirect_to("/user/#{@user.id}")
        else
          @error_message = "Invalid email address or password."
          @email = params[:email]
          @password = params[:password]
          render("user/login_form")
        end
    end

    # Use this hash value for searching purpose (e.g. login)
    def generate_hash(*args)
        Digest::SHA3.hexdigest(args.join(''))
    end

    ### Logout ###
    def logout
        session[:user_id] = nil
        flash[:notice] = "Logged out."
        redirect_to("/login")
    end
end
