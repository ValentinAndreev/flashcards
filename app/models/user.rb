class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :packs, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: { case_sensitive: false }
  
  def review_pack(pid = nil)
    unless pid
      pack = Pack.find_by("base = :basep AND user_id = :user", { basep: true, user: id })
    else
      pack = Pack.find_by("id = :idp AND user_id = :user", { idp: pid, user: id })
    end
      pack if pack
  end
  
  private
  def user_params
    params.permit(:user).require(:email, :password, :authentications_attributes [:user_id, :provider, :uid])
  end
end