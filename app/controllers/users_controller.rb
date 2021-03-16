class UsersController < ApplicationController

  def index
    @notes = policy_scope(Note).order(created_at: :desc)
  end
end
