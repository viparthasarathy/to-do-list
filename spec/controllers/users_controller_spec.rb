require_relative "../spec_helper.rb"

describe UsersController do

  before do
    @user = User.create(username: "Bob", password: "bob")
  end

  describe "Signup" do

    it "allows user to view a form to sign up" do
      get '/signup'
      expect(last_response.status).to eq(200)
      expect(page.body).to include('<form')
    end

    it "allows user to sign up and redirects user to their home page" do
      params = {
        username: "Mike",
        password: "Mikey"
      }
      post '/signup', params
      expect(last_response.location).to include("/home")
      expect(User.all.count).to eq(2)
      expect(current_user).to eq(User.last)
    end

    it "doesn't sign user up and gives user an error message if empty parameters are entered" do
      params = {
        username: "",
        password: "rite"
      }
      post '/signup', params
      expect(last_response.location).to include("/signup")
      expect(last_response.body).to include("Please enter an username and password.")
      expect(User.all.count).to eq(1)
    end

    it "doesn't sign user up and gives user error message if username is taken" do
      params = {
        username: "Bob",
        password: "notbobby"
      }

      post '/signup', params
      expect(last_response.location).to include("/signup")
      expect(last_response.body).to include("Username is taken.")
      expect(User.last.authenticate("notbobby")).to eq(false)
    end

    it "doesn't allow user to signup if user is already logged in" do
      params = {
        username: "Bob",
        password: "bob"
      }
      post '/login', params
      get '/signup'
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include("/home")
      params = {
        username: "Ham",
        password: "Turkey"
      }
      post '/signup', params

      expect(last_response.location).to include("/home")
      expect(User.all.count).to eq(1)
    end

  end

  describe "Login" do

    it "allows user to view a form to log in" do
      get '/login'
      expect(last_response.status).to eq(200)
      expect(page.body).to include('<form')
    end

    it "logs user in and redirects user to user home page" do
      params = {
        username: "Bob",
        password: "bob"
      }
      post '/login', params
      expect(last_response.location).to include("/home")
      expect(current_user).to eq(@user)
    end

    it "doesn't log user in and gives an error message if wrong parameters are entered" do
      params = {
        username: "Bob",
        password: ""
      }
      post '/login', params
      expect(last_response.location).to include("/login")
      expect(last_response.body).to include("Username and/or password is incorrect.")
      expect(logged_in?).to eq(false)
    end

    it "doesn't allow user to log in if user is already logged in" do
      params = {
        username: "Bob",
        password: "bob"
      }
      post '/login', params
      get '/login'
      expect(last_response.status).to eq(302)
      expect (last_response.location).to include("/home")
      params2 = {
        username: "John",
        password: "heresjohnny"
      }
      @user2 = User.create(params2)
      post '/login', params2
      expect(current_user).to eq(@user)
    end

  end

end
