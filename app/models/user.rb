class User < ActiveRecord::Base	
	has_secure_password

	before_save :downcase

	validates :first_name, :last_name, :city, presence: true, length: { in: 2..40 }
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i }

	has_many :events
	has_many :joins, dependent: :destroy
	has_many :events_joined, through: :joins, source: :event
	
	def downcase
		self.first_name.downcase!
		self.last_name.downcase!
		self.email.downcase!
	end
end
