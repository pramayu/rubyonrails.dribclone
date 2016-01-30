class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :profile, styles: { medium: "80x80#", thumb: "48x48#", small: "32x32#", xsmall: "18x18#", xssmall: "16x16#" }
  validates_attachment_content_type :profile, content_type: /\Aimage\/.*\Z/

end
