class StaticController < ApplicationController

  def about
    session['has_read_about_notice_1'] = true
  end

  def contact
  end

  def policy
  end

  def markdown
  end

  def prerelease
    session['has_read_alpha_notice_1'] = true
  end

end
