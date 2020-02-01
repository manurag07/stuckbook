# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def accept_friendship
    update_attributes(state: 'active', friended_at: Time.now)
  end

  def deny_friendship
    destroy
  end

  def cancel_friendship
    destroy
  end
end
