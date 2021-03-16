class NotesController < ApplicationController

  def create
    authorize @note
  end
end
