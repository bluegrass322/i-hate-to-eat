module SignupAndLoginMacros
  def signup_and_login(trait_name = nil)
    create(:dietary_reference_intake)
    @user = create(:user, trait_name)

    post api_v1_authentication_path, params: { name: @user.name, password: "password" }
  end
end
