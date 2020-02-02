# frozen_string_literal: true

module UsersHelper
  def action_buttons(user)
    case current_user.friendship_status(user)
    when 'Friends'
      'Remove Friendship'
    when 'Pending'
      'Cancel Request'
    when 'Requested'
      'Accept or Deny'
    when 'not friend'
      'Add as a Friend'
    end
  end
end
