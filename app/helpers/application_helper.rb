module ApplicationHelper

  def logged_in_member
    member = Member.find(session['id'])
  end

end
