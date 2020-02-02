# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id', dependent: :destroy

  def request_friendship(user2)
    friendships.create(friend: user2)
  end

  def pending_friend_request_from
    inverse_friendships.where(state: 'pending')
  end

  def pending_friend_request_to
    friendships.where(state: 'pending')
  end

  def active_friends
    friendships.where(state: 'active').map(&:friend) + inverse_friendships
                                                       .where(state: 'active')
                                                       .map(&:user)
  end

  def friendship_status(user2)
    friendship = Friendship.where(user_id: [id, user2.id],
                                  friend_id: [id, user2.id])
    if friendship.none?
      return 'not friend'
    elsif friendship.first.state == 'active'
      return 'Friends'
    elsif friendship.first.user == self
      return 'Pending'
    else
      return 'Requested'
    end
  end
end
