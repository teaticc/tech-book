class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      # session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_path, flash: { error: "Facebookでの認証に失敗しました" }
    end
  end

  def google_oauth2
    @user = User.from_google_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      # session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to root_path, flash: { error: "Googleでの認証に失敗しました" }
    end
  end

  def twitter
    set_dummy_email
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      redirect_to root_path, flash: { error: "Twitterでの認証に失敗しました" }
    end
  end

  def yahoojp
    @user = User.from_yahoo_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Yahoo") if is_navigational_format?
    else
      redirect_to root_path, flash: { error: "Yahooでの認証に失敗しました" }
    end
  end
  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  def failure
    redirect_to root_path
  end

  protected

  def set_dummy_email
    request.env["omniauth.auth"].info.email = request.env["omniauth.auth"].info.nickname + "@dummy.com"
  end

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
