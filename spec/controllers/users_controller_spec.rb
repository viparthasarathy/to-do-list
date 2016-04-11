require_relative "../spec_helper.rb"

describe UsersController do

  before do
    @user = User.create(username: "Bob", password: "bob")
  end

  describe "Signup" do

    it "allows user to view a form to sign up" do
      get '/signup'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('<form')
    end

    it "allows user to sign up and redirects user to their home page" do
      params = {
        username: "Mike",
        password: "Mikey"
      }
      post '/signup', params
      expect(last_response.location).to include("/home")
      expect(User.all.count).to eq(2)
      expect(User.last.username).to eq("Mike")
    end

    it "doesn't sign user up if empty parameters are entered" do
      params = {
        username: "",
        password: "rite"
      }
      post '/signup', params
      expect(User.all.count).to eq(1)
    end

    it "doesn't sign user up if username is taken" do
      params = {
        username: "Bob",
        password: "notbobby"
      }

      post '/signup', params
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
      expect(last_response.body).to include('<form')
    end

    it "logs user in and redirects user to user home page" do
      params = {
        username: "Bob",
        password: "bob"
      }
      post '/login', params
      expect(last_response.location).to include("/home")
    end

    it "doesn't log user in and gives an error message if wrong parameters are entered" do
      params = {
        username: "Bob",
        password: ""
      }
      post '/login', params
      get '/home'
      expect(last_response.location).to include("/login")
    end

    it "doesn't allow user to log in if user is already logged in" do
      params = {
        username: "Bob",
        password: "bob"
      }
      post '/login', params
      get '/login'
      expect(last_response.status).to eq(302)
      expect(last_response.location).to include("/home")
      params2 = {
        username: "John",
        password: "heresjohnny"
      }
      @user2 = User.create(params2)
      post '/login', params2
      get '/home'
      expect(last_response.body).to_not include("#{@user2.username}")
    end
  end

  describe "Logout" do

    it "lets a user logout if they are logged in" do
      params = {
        username: "Bob",
        password: "bob"
      }
      post '/login', params
      get '/logout'
      expect(last_response.location).to include("/login")
    end

    it "redirects a non-logged in user to sign up if they try to logout" do
      get '/logout'
      expect(last_response.location).to include("/signup")
    end
  end

end
