module SignupAndLoginMacros
  def signup_and_login
    create(:dietary_reference_intake)
    @user = create(:user)

    post api_v1_authentication_path, params: { name: @user.name, password: "password" }
  end
end
