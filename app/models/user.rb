class User < ActiveRecord::Base
  has_many :listings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]


	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
      user.token = auth.credentials.token
	    # user.name = auth.info.name   # assuming the user model has a name
	    # user.image = auth.info.image # assuming the user model has an image
	  end
	end

	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def prof_pic
    graph = Koala::Facebook::API.new(self.token)
    
    #@friends = graph.get_connections("me", "friends")
    graph.get_object("me?fields=name,picture")['picture']['data']['url'].to_s
  end

  def friends
    graph = Koala::Facebook::API.new(self.token)
    
    #@friends = graph.get_connections("me", "friends")
    graph.get_connections("me", "friends", api_version: 'v2.0')
  end

  def get_name
    graph = Koala::Facebook::API.new(self.token)
    graph.get_object("me?fields=name")['name']
  end

end
